
class Refresh
  attr_reader :configdir

  def initialize(dirpath)
    abs_path = File.absolute_path(dirpath)
    @configdir = File.join(abs_path, "mygit.d")
    @pastel = Pastel.new
  end

  def call
    puts "refresh: #{@configdir}"
  end
end
