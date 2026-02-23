
class Config
    attr_reader :dirpath
    attr_reader :abs_dirpath
    attr_reader :configdir
  
    def initialize(dirpath)
      @dirpath =dirpath 
      @abs_dirpath = File.absolute_path(@dirpath)
      @configdir = File.join(@abs_dirpath, "mygit.d")
      @pastel = Pastel.new
    end
  
    def exist?
    
      puts "config:"
    end
  end
  