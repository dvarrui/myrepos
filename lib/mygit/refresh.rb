require_relative "config"

class Refresh
  def initialize(dirpath)
    @config = Config.new(dirpath)
    @pastel = Pastel.new
  end

  def call
    puts "refresh: #{@config.configdir}"
  end
end
