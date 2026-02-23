# frozen_string_literal: true

require "test_helper"

class ConfigTest < Test::Unit::TestCase
  def setup
    dirpath = File.join(File.dirname(__FILE__), "files", "config.ok")
    @config_ok = Config.new(dirpath)
    dirpath = File.join(File.dirname(__FILE__), "files", "config.err")
    @config_err = Config.new(dirpath)
  end

  test "Config attributes" do
    abs_dirpath = File.absolute_path(@config_ok.dirpath)
    assert_equal abs_dirpath, @config_ok.abs_dirpath

    config_dir = File.join(abs_dirpath, "mygit.d")
    assert_equal config_dir, @config_ok.config_dir
  end

  test "Config is_ok?" do
    assert @config_ok.is_ok?
    assert !@config_err.is_ok?
  end
end
