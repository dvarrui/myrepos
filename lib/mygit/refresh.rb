require_relative "config"

class Refresh
  def initialize(dirpath)
    @config = Config.new(dirpath)
    @pastel = Pastel.new
  end

  def call
    puts "==> [mygit] Refreshing..."
    @config.load
    puts @config.data.to_s
  end
end
