#!/usr/bin/env ruby
require_relative "lib/gitlab"
require "colorize"

data = gitlab.group(ENV['GITLAB_GROUP_ID'])
group = data.to_h

projects = group['projects']
labels = %w(id name http_url_to_repo web_url visibility empty_repo last_activity_at creator_id)

projects.each_with_index do |project, index|
  puts "\n#{" "*13}INDEX: #{index}"
  labels.each do |label|
    puts "#{label.rjust(18)}: #{project[label]}"
  end
end
