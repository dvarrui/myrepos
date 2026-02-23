require "fileutils"
require "pastel"

class Init
  attr_reader :configdir

  def initialize(dirpath)
    abs_path = File.absolute_path(dirpath)
    @configdir = File.join(abs_path, "mygit.d")
    @pastel = Pastel.new
  end

  def call
    create_dir(@configdir)
    copy_files_into(@configdir)
    puts @pastel.green("Configuration files created!")
  end

  private

  def create_dir(dirpath)
    return if Dir.exist? dirpath
    begin
      FileUtils.mkdir_p(dirpath)
    rescue
      puts @pastel.red "ERROR: Directory not created (#{dirpath})"
      exit 1
    end
  end

  def copy_files_into(targetdir)
    sourcedir = File.absolute_path(File.join(File.dirname(__FILE__), "files", "config"))
    dirpath = File.join(sourcedir)
    files = Dir.glob("#{dirpath}/*")
    files += Dir.glob("#{dirpath}/.?*")
    FileUtils.cp_r(files.sort, targetdir)
  end
end
