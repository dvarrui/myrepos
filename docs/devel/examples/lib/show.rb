require "colorize"

def show(label, text)
  if label == :separator
    $stdout.puts ""
    $stdout.puts "#{" " * 18}  #{text.colorize(:green)}"
  else
    $stdout.puts "#{label.rjust(18).colorize(:green)}: #{text}"
  end
  $stdout.flush
end
