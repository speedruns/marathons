def run
  loop do
    STDOUT.puts "hello"
    sleep(1)
    raise "woops"
  end
end
