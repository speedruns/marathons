require "http"

class CustomAssetHandler < HTTP::StaticFileHandler
  property path_prefix : Regex

  # `directory` is the directory on the server where the custom assets are
  # kept. `path_prefix` is the part of the request path that will be trimmed
  # before looking up the requested file. The event context will also be
  # injected into the request path to load the correct event's assets.
  #
  # For example, with a `directory` of `public/custom_assets`, a `path_prefix`
  # of '/assets/', and an event context of 'the-event':
  #
  #   '/assets/css/style.css' => 'public/custom_assets/the-event/css/style.css'
  #   '/assets/main.js'       => 'public/custom_assets/the-event/main.js'
  def initialize(directory : String, path_prefix : String = "assets")
    super(directory, fallthrough: false, directory_listing: false)
    @path_prefix = /\/?#{path_prefix}\/?/
  end

  def call(context)
    asset_path = context.request.path.sub(@path_prefix, "")
    context.request.path = File.join("/", event_dir(context), asset_path)
    super(context)
  end

  private def event_dir(context)
    "#{context.event.id}"
  end
end
