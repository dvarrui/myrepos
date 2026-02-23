# frozen_string_literal: true

require "test_helper"

class ConfigTest < Test::Unit::TestCase

  def setup
    dirpath = File.join(File.dirname(__FILE__), "files")
    @config = Config.new(dirpath)
  end

  test "Config attributes" do
    abs_dirpath = File.absolute_path(@config.dirpath)
    assert_equal abs_dirpath, @config.abs_dirpath

    configdir = File.join(abs_dirpath, "mygit.d")
    assert_equal configdir, @config.configdir
  end

  test "Config exist?" do
    assert @config.exist?
  end
end