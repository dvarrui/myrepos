#!/usr/bin/env ruby
require_relative "lib/gitlab"
require "colorize"

data = gitlab.user.to_h
labels = %w[id username name web_url email followers]

labels.each do |label|
  puts "#{label.rjust(15).colorize(:green)} #{data[label]}"
end
