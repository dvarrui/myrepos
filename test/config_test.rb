# frozen_string_literal: true

require "test_helper"

class ConfigTest < Test::Unit::TestCase

  test "Create Config object" do
    dirpath = File.join(File.dirname(__FILE__), "files")
    config = Config.new(dirpath)

    assert_equal dirpath, config.dirpath

    abs_dirpath = File.absolute_path(dirpath)
    assert_equal abs_dirpath, config.abs_dirpath

    configdir = File.join(abs_dirpath, "mygit.d")
    assert_equal configdir, config.configdir
  end
end