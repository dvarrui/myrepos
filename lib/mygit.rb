# frozen_string_literal: true

require_relative "mygit/init"
# require_relative "mygit/log"
# require_relative "mygit/params"
# require_relative "mygit/pull"
# require_relative "mygit/rules"
# require_relative "mygit/status"
require_relative "mygit/test"
require_relative "mygit/version"

module Mygit
  def self.init(dirpath, mode)
    InitRepo.new(dirpath).call(mode)
  end

  def self.log
    Log.new(Dir.pwd).call
  end

  def self.params
    Params.new(Dir.pwd).call
  end

  def self.pull
    action = Pull.new(Dir.pwd).call
    action.show
  end

  def self.rules
    action = Rules.new(Dir.pwd).call
    action.show
  end

  def self.show_status(dirpath)
    status = Status.new(Dir.pwd)
    status.show
  end

  def self.show_version
    puts "mygit #{Mygit::VERSION}"
  end

  def self.test
    Test.call
  end
end
