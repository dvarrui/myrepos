#!/usr/bin/env ruby
require_relative "lib/gitlab"
require_relative "lib/show"

def show_info(groups)
  labels = %w(id parent_id name full_path)
  groups.each_with_index do |group, index|
    show :separator, "Group[#{index}]"
    labels.each do |label|
      show(label, group[label])
    end
    key = "projects"
    projects = @server.group(group["id"])[key]
    names = projects.map { _1["name"]}
    show("#{key}(#{names.size})", names.sort.join(", "))
  end
end

def get_gitlab_groups(server)
  page = @server.groups
  groups = page.to_a.clone

  while not page&.next_page.nil?
    page = page.next_page
    groups += page.to_a.clone
  end
  groups
end

@server = gitlab
groups = get_gitlab_groups(@server)
show_info(groups)
