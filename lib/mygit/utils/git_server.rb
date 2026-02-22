require "dotenv"
require "gitlab"

class GitServer
  def gitlab
    Dotenv.load("./.env")
    endpoint = ENV["GITLAB_API_ENDPOINT"]
    private_token = ENV["GITLAB_API_PRIVATE_TOKEN"]
    Gitlab.client(
      endpoint: endpoint, 
      private_token: private_token
      )
  end
end
