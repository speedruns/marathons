module Util
  module TimeParse
    extend self

    KNOWN_TIME_FORMATS = [
      "%H:%M:%S.%3N",
      "%H:%M:%S",
      "%M:%S",
      "%M.%S"
    ]

    def to_milliseconds!(time_string : String) : Int32
      result =
        KNOWN_TIME_FORMATS.each do |format|
          time = Time.parse(time_string, format, Time::Location::UTC)

          break time.hour * 3_600_000 +
                time.minute * 60_000 +
                time.second * 1000 +
                time.millisecond
        rescue
          nil
        end

      result || raise "Unable to parse time string `#{time_string}` using KNOWN_TIME_FORMATS."
    end

    def to_milliseconds(time_string : String) : Int32?
      begin
        to_milliseconds!(time_string)
      rescue
        nil
      end
    end
    def to_milliseconds(time_string : Nil); nil; end


    def time_parts_to_milliseconds(hours, minutes, seconds, ms=0)
      hours * 3_600_000 +
      minutes * 60_000 +
      seconds * 1000 +
      ms
    end


    def format_time(time : Nil); ""; end
    def format_time(time : Time::Span)
      "#{time.hours}:#{time.minutes}:#{time.seconds}.#{time.milliseconds}"
    end
    def format_time(ms : Int)
      h = ms / 1000 / 60 / 60
      m = ms / 1000 / 60 % 60
      s = ms / 1000 % 60
      ms = ms % 1000
      sprintf("%02d:%02d:%02d.%03d", h, m, s, ms)
    end
    def format_time(time : String)
      if ms = to_milliseconds(time)
        format_time(ms)
      else
        time
      end
    end
  end
end
