require "fileutils"
require "pastel"

class Config
  attr_reader :dirpath
  attr_reader :abs_dirpath
  attr_reader :configdir

  def initialize(dirpath)
    @dirpath = dirpath
    @abs_dirpath = File.absolute_path(@dirpath)
    @configdir = File.join(@abs_dirpath, "mygit.d")
    @pastel = Pastel.new
    # configfiles = Dir.
  end

  def is_ok?
    (template_files - real_files).empty?
  end

  def create
    return true if is_ok?
    configdir = @configdir
    create_dir(configdir)
    copy_files_into(configdir)
    puts @pastel.green("Configuration created!")
    true
  end

  private

  def template_filepaths
    sourcedir = File.absolute_path(File.join(File.dirname(__FILE__), "files", "config"))
    dirpath = File.join(sourcedir)
    files = Dir.glob("#{dirpath}/*")
    files += Dir.glob("#{dirpath}/.?*")
    files
  end

  def template_files
    template_filepaths.map { File.basename(_1) }
  end

  def real_files
    dirpath = @configdir
    files = Dir.glob("#{dirpath}/*")
    files += Dir.glob("#{dirpath}/.?*")
    files.map { File.basename(_1) }
  end

  def create_dir(dirpath)
    FileUtils.mkdir_p(dirpath)
  rescue
    puts @pastel.red.bold "ERROR | Creating folder!"
    puts @pastel.red "      | #{dirpath}"
    exit 1
  end

  def copy_files_into(configdir)
    FileUtils.cp_r(template_filepaths.sort, configdir)
  rescue
    puts @pastel.red.bold "ERROR | Creating config files!"
    template_filenames.each do |filename|
      puts @pastel.red "      | #{filename}"
    end
    exit 1
  end
end
