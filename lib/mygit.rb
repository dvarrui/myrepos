# frozen_string_literal: true

require_relative "mygit/utils/git_server"
require_relative "mygit/version"

module Mygit
  def self.init(dirpath)
  end

  def self.show_version
    puts "mygit #{Mygit::VERSION}"
  end

  def self.test_server_conn
    server = GitServer.gitlab
    puts "Conexión OK (#{server.user.to_h["name"]})"
  end
end
