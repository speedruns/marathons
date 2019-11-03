# RTMP Streaming Setup

For online marathons, you'll need some way to get game feeds from runners onto your main event stream. For a long time, this was just done by loading their stream from Twitch or Hitbox, but in recent years, more people have started using custom RTMP servers to make sure their streams are private and that viewership is focused on the event stream, rather than spread across the runners' streams.

Setting up an RTMP server is much easier than it sounds. If you are at all familiar with using a Unix command line, you can go from nothing to a running server in about 10 minutes. They also use incredibly small amounts of CPU, and can run on any computer, all the way down to a Raspberry Pi! I like using DigitalOcean droplets for hosting because they have high bandwidth internet connections, I can make new ones across the globe to reduce latency and improve connection quality, and it's cheap and charged by the hour. For a 2 day event, you can run multiple servers the entire time for less than $8.

_This guide is an expansion of [this RTMP setup guide](https://obsproject.com/forum/resources/how-to-set-up-your-own-private-rtmp-server-using-nginx.50/) from a few years ago, updated and expanded to provide a more complete stream management guide._


## Initial RTMP Setup

Once you have your machine booted up, you'll need to install the RTMP server software. There's a great, open source Nginx plugin available that most people use, and that we'll use in this guide: https://github.com/arut/nginx-rtmp-module.

### Install Nginx and the RTMP module

This is a mostly automatic process that just takes a few commands to download and install everything. It does not matter where you run any of these commands from, as the install will automatically put them in the right places. First up, dependencies:

```
sudo apt-get update
sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev
apt-get install --reinstall zlibc zlib1g zlib1g-dev
```

The top line are general dependencies of Nginx and the RTMP module. The second line is for unzipping the source archives while we're installing. If you can use `unzip` on the machine successfully, you probably don't need to run that line.

Up next, downloading and unpacking:

```
wget http://nginx.org/download/nginx-1.15.1.tar.gz
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
apt install unzip
unzip master.zip 
cd nginx-1.15.1/
tar xvf nginx-1.15.1.tar.gz 
cd nginx-1.15.1/
```

Nothing crazy here, just downlading the source archives and unzipping them into full folders. Last step of installation, building Nginx with the RTMP module included:

```
./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
make
sudo make install
```

With that you should be able to start Nginx and see that it's running:

```
sudo /usr/local/nginx/sbin/nginx
ps aux | grep nginx
```

The `ps aux` line should show two entries for Nginx: a master and a worker process. If it does, nginx is running and your installation is complete.

### Configuring RTMP

Now that everything is running, we can edit the configuration to make the RTMP service available. Open up the nginx configuration in an editor of your choice:

```
nano /usr/local/nginx/conf/nginx.conf
```

Then add these lines to the bottom of the file:

```
rtmp {
  server {
    listen 1935;
    chunk_size 4096;

    application live {
      live on;

      play_restart on;
      record off;
    }
  }
}
```

I won't bother explaining all of what's happening here, but essentially it's saying to make an RTMP server available on port 1935 (the default port for the RTMP protocol), then to make it available for other people to load.

### Testing streams and URLs

Runners should stream to the server using the URL `rtmp://your.rtmp.server.com/live` and a stream key of your choosing. To test the stream, you can load it in VLC or any other network player at the same URL with their stream key appended to it. So, as an example:

```
Runner OBS Stream URL: rtmp://stream.example.com/live
Runner OBS Stream Key: my_dude
VLC Stream URL: rtmp://stream.example.com/live/my_dude
```

It's important to note that **the stream keys and URL are case sensitive**. For simplicity, it's easiest to tell runners to only use lowercase letters.

### Multi-server Setup

If you have runners streaming from around the world, some of them may experience lots of dropped frames or latency from the server being too far away and their connection not being strong enough. The best thing to do in this situation is make a second server for them and have that server push the stream on to your main server.

For example: In Spyrothon 4 we had people streaming from all over Europe, Eastern US, Western US, Saudi Arabia, and New Zealand. Our main server was set up in San Francisco, and the runners in Europs and Saudi Arabia were dropping a lot of frames trying to connect to it. The solution was to add new servers in London and New York, then have the San Francisco and London servers push streams to the New York server. Having the servers push the stream most of the distance lets us use their data center-tier internet connections that are lower latency and higher bandwidth, and the New York server was closer to our streaming location, so that was made to reduce latency on our end.

To configure multiple servers, run the same setup as above on each one, then all you have to do is add a single line on the other servers to push to your primary one. The full rtmp configuration for those would look like this:

```
rtmp {
  server {
    listen 1935;
    chunk_size 4096;

    application live {
      live on;

      play_restart on;
      record off;
      
      push rtmp://your.primary.rtmp.server.com/live;
    }
  }
}
```

The `push` line is the only thing added here. It works just like the OBS setup does, the stream key will get passed through automatically.

Using this setup, you can also consolidate what you load on your end to one server and know that all the streams will be available there. Similar to how Twitch has multiple ingest servers, but you can always access it from just `twitch.tv/username`.


## Runner Setup

Make sure your runners know how to connect and what settings to use for their streams. Also make sure that you know what resolutions you want people to stream at beforehand so you can answer any questions quickly and consistently. For example, a decent setup that most people can handle is 854x480 (16:9 480p) at 30fps with a minimum bitrate of 1500. Especially with multiple servers, even people with mediocre internet connections should be able to stream well.

You'll also want to have runners set their Keyframe Interval manually. The interval is the time between keyframes in the stream, in seconds. To start loading a stream in OBS, it needs 3 keyframes, so having this value as low as possible will reduce latency and make sure that if streams start lagging or dropping frames, it will reset itself quickly.

Ideally, this should be set to 1 for all runneres (0 is "automatic" in OBS, and will default to 10 seconds). A lower keyframe interval can also cause higher CPU usage, though, so if someone's computer is struggling, raise the interval to 4 or 5 to lighten the load.

It's best to communicate this setup as soon as possible while organizing your event. Give runners enough time to test their setups when they can and ask questions if they have any issues.


Here's an example introduction that we used for Spyrothon 4:

>The streaming server that we'll be using for Spyrothon is now up and ready for you to test! I assume everyone here is using OBS so I'll explain how to set that up here. If you use something else, let me know.
>
>## Stream Setup
>
>First, go to Settings->Stream. For "Stream Type", select Custom Streaming Server. Two fields, URL and Stream Key, will show up below.
>
>For the URL, use rtmp://stream.marathons.gg/live. For the stream key, please use your twitch username.
>
>That's it for settings; hit OK and exit the settings window. Then start streaming and make sure that OBS is able to connect to the server. Remember that this is a private RTMP server, so no one will see that you are streaming to it.
>
>To test that your stream is working correctly, you can use VLC Media Player. Go to File->Open Network, and then enter the URL rtmp://stream.marathons.gg/live/your_twitch_name. Hit open and your stream should show up. If it does, testing is done and you can stop. If you can't get VLC working, let me know and I will help test.
>
>## Stream Content
>
>Please only include the game video and audio on your stream. The game video should be the full size of the stream window vertically, and centered horizontally. Your microphone audio should not be on the stream. We will use a discord call for all commentary.
>
>For resolution, please stream at 854x480, 30fps with a maximum bitrate of 4000. If you are not able to stream at 480p with a bitrate of at least 1000, please let me know in a DM and we will work out the details from there. (For SRT, please stream 1280x720, 30fps with a bitrate of at least 1700).
>
>
>PLEASE RUN A QUICK TEST STREAM TO MAKE SURE YOU HAVE EVERYTHING CONFIGURED CORRECTLY Please check with your commentators while testing to make sure they can see your stream as well. Then send a message here or DM me saying that you have tested and that it worked. If you have any issues with configuration, DM me.
>
>------
>
>@commentator If you are commentating someone else's run, the best way to view it with as little delay as possible is to stream directly from our RTMP server. Check with the runner(s) you will be commentating for to see if they can run a test for you.
>
>To load the stream, you'll need VLC Media Player (or any other network stream video client if you have another one you like). GO to File->Open Network and enter the url rtmp://stream.marathons.gg/live/runners_twitch_name. Hit Open. If they are streaming, you should see their stream pop up.
>
>Let me know if you have any issues with this setup.

Note that this example left out the Keyframe Interval setup. It should have been included but was accidentally left out, and we had to talk to every runner during their setup to make sure it was set properly. It was a nice reminder that we needed to be more prepared! Of course sometimes things just slip through, and we were able to handle it just fine.



## Stream Setup

To load RTMP streams in OBS, it's best to use the VLC Video Source. If you have [VLC Media Player installed](https://www.videolan.org/vlc/download-windows.html), it should show up in the Source Type list in OBS automatically. **Make sure that you get the 64-bit version if you have 64-bit OBS!** You'll need to hit the down arrow and specifically select the 64 bit installer for this. You may have to restart OBS after installing VLC for the source type to show up.

### Creating the Video Source

Create a VLC Video Source in your scene. In the properties, hit the `+` icon on the Playlist section, and add the rtmp stream URL as described above (`rtmp://stream.example.com/live/<runners_stream_key>`). Hit OK and you should see the stream show up. If not, make sure you have the right Visibility Behavior as described below, and double check your URL and the runner's setup.

### Visibility Behavior

OBS Studio Mode has a quirk where the stream sources won't show up unless they are actively being output on the stream. This means that you won't see them in the Preview window, only on the Live window.

To get the stream sources to show up in the Preview window, you'll need to change the Visbility Behavior of the source to "Always play even when not visible". Give it a few seconds and it should show up on the Preview Window.

**NOTE:** setting this will make the stream play even when the scene is not active/in preview. This can use up a lot of CPU and network bandwidth if you have multiple sources, so be sure to set each one back to "Stop when not visible, restart when visible" when you are not using them.


## Authentication and Privatization

The `nginx-rtmp-module` has callbacks for authentication on publish, playback, and stopping. The [example configuration from the RTMP module](https://github.com/arut/nginx-rtmp-module/blob/791b6136f02bc9613daf178723ac09f4df5a3bbf/README.md#example-nginxconf) shows how to use the `on_publish` hook as a callback for authentication.

This requires having an external service to do authentication. Hopefully when I get around to implementing this on my own servers I will expand on this section of the guide.
