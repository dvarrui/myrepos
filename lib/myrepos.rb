# frozen_string_literal: true

require_relative "myrepos/config"
require_relative "myrepos/refresh"
require_relative "myrepos/version"

module MyRepos
  def self.init(dirpath)
    config = Config.new(dirpath)
    config.create
  end

  def self.refresh(dirpath)
    refresh = Refresh.new(dirpath)
    refresh.call
  end

  def self.show_version
    puts "mygit #{MyRepos::VERSION}"
  end
end
