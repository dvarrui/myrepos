# frozen_string_literal: true

require_relative "mygit/init"
require_relative "mygit/refresh"
require_relative "mygit/version"

module Mygit
  def self.init(dirpath)
    init = Init.new(dirpath)
    init.call
  end

  def self.refresh(dirpath)
    refresh = Refresh.new(dirpath)
    refresh.call
  end

  def self.show_version
    puts "mygit #{Mygit::VERSION}"
  end
end
