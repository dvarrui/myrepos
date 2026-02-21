#!/usr/bin/env ruby
require_relative "lib/gitlab"

data = gitlab.group(ENV['GITLAB_GROUP_ID'])

if data.is_a? Gitlab::ObjectifiedHash
  list = [ data ]
else
  list = data.to_a
end

labels = %w(id parent_id name full_name full_path )
list.each_with_index do |item, index|
  puts ""
  puts "#{"index".rjust(15).colorize(:green)} #{index}"
  data = item.to_h
  labels.each do |label|
    puts "#{label.rjust(15).colorize(:green)} #{data[label]}"
  end

  unless data['projects'].nil?
    puts "projects".rjust(15)
    data['projects'].each do |project|
      puts "#{project['id'].to_s.rjust(15).colorize(:green)} #{project['name']}"
    end
  end
end
