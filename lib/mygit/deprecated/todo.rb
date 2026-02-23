def self.test_server_conn
    server = GitServer.gitlab
    puts "Conexión OK (#{server.user.to_h["name"]})"
  end
