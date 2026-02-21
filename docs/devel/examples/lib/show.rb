require "colorize"

def show(label, text)
  if label == :separator
    STDOUT.puts ""
    STDOUT.puts "#{" " * 18}  #{text.colorize(:green)}"
  else
    STDOUT.puts "#{label.rjust(18).colorize(:green)}: #{text}"
  end
  STDOUT.flush
end
