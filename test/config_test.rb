# frozen_string_literal: true

require "test_helper"

class ConfigTest < Test::Unit::TestCase
  def setup
    dirpath = File.join(File.dirname(__FILE__), "files", "config.ok")
    @config_ok = MyRepos::Config.new(dirpath)
    dirpath = File.join(File.dirname(__FILE__), "files", "config.err")
    @config_err = MyRepos::Config.new(dirpath)
  end

  test "Config attributes" do
    abs_dirpath = File.absolute_path(@config_ok.dirpath)
    assert_equal abs_dirpath, @config_ok.abs_dirpath

    config_dir = File.join(abs_dirpath, MyRepos::CONFIG_BASEDIR)
    assert_equal config_dir, @config_ok.config_dir
  end

  test "Config is_ok?" do
    assert @config_ok.is_ok?
    assert !@config_err.is_ok?
  end

  test "Config ok values" do
    @config_ok.load
    assert "first/folder", @config_ok.data[:local_repos].first
    assert "endpoint_url", @config_ok.data[:remote_server][:endpoint]
    assert "secret_token", @config_ok.data[:remote_server][:private_token]
  end
end
