require "fileutils"
require "pastel"
require "yaml"

class Config
  attr_reader :dirpath
  attr_reader :abs_dirpath
  attr_reader :config_dir
  attr_reader :data

  CONFIG_BASEDIR = "mygit.d"
  MAIN_CONFIG_FILENAME = "config.yaml"

  def initialize(dirpath)
    @pastel = Pastel.new

    @dirpath = dirpath
    @abs_dirpath = File.absolute_path(@dirpath)
    @config_dir = File.join(@abs_dirpath, CONFIG_BASEDIR)
    @config_filepath = File.join(@config_dir, MAIN_CONFIG_FILENAME)
    @data = {}
  end

  def is_ok?
    (template_files - real_files).empty?
  end

  def create
    return true if is_ok?
    puts "==> [mygit] Creating configuration..."
    configdir = @config_dir
    create_dir(configdir)
    copy_files_into(configdir)
    puts @pastel.green("==> [mygit] Done!")
    true
  end

  def load
    if !is_ok?
      puts @pastel.red.bold "==> [mygit] ERROR: Config file not found!"
      puts @pastel.blue.bold "==> [mygit] Usage: mygit init"
      exit 1
    end

    begin
      @data = YAML.load_file(@config_filepath)
    rescue => e
      puts "ERROR: malformed YAML file! (#{e.message})"
      @data = {}
    end
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
    dirpath = @config_dir
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

  def copy_files_into(config_dir)
    FileUtils.cp_r(template_filepaths.sort, config_dir)
  rescue
    puts @pastel.red.bold "ERROR | Creating config files!"
    template_filenames.each do |filename|
      puts @pastel.red "      | #{filename}"
    end
    exit 1
  end
end
