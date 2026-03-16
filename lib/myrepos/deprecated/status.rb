require "pastel"

class Status
  def initialize(workdir)
    @workdir = workdir
    @pastel = Pastel.new
  end

  def show
    output "Repo git", dirpath
    output "Current branch", current_branch
    output "Branch list", branch_list.join(", ")
    output "Remote URL", remote_url
    output "Tag list", tag_list.join(", ")
  end

  def branch_list
    list = []
    config = config()
    config.select { _1.start_with? "[branch " }.each do |line|
      name = /branch\s+"([\w.-]+)"/.match(line)
      list << name.captures[0] unless name.nil?
    end
    list
  end

  def config
    File.read(File.join(dirpath, "config")).split("\n")
  end

  def current_branch
    File.read(File.join(dirpath, "HEAD")).split("/").last
  end

  def dirpath
    dirbase = @workdir.split(File::SEPARATOR)
    dirpath = File.join(dirbase, ".git")
    while !Dir.exist?(dirpath) && !dirbase.empty?
      dirbase.pop
      dirpath = File.join(dirbase, ".git")
    end
    unless Dir.exist? dirpath
      puts "    WARN: No git repo [#{@workdir}]"
      exit 1
    end
    dirpath
  end

  def remote_url
    list = []
    config = config()
    config.each do |line|
      next unless line.include? "url"
      name = /\s+url\s+=\s+([\w.@:\/-]+)/.match(line)
      list << name.captures[0] unless name.nil?
    end
    list.first
  end

  def tag_list
    `git tag --list`.split("\n")
  end

  private

  def output(label, value)
    puts "#{@pastel.green(label.rjust(16))}  #{value}"
  end
end
