require "dotenv"
require "gitlab"

# TODO:
# - Create Conn or GitServer class
module Test
  def self.call
    Dotenv.load("./.env")
    endpoint = ENV["GITLAB_API_ENDPOINT"]
    private_token = ENV["GITLAB_API_PRIVATE_TOKEN"]

    g = Gitlab.client(
      endpoint: endpoint,
      private_token: private_token
    )

    puts "Conexión OK (#{g.user.to_h["name"]})"
  end
end
