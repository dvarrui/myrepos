require "fileutils"
require "pastel"

class InitRepo
  attr_reader :sourcedir
  attr_reader :targetdir

  def initialize(dirpath)
    @targetdir = dirpath
    @sourcedir = File.absolute_path(File.join(File.dirname(__FILE__), "files"))
    @pastel = Pastel.new
  end

  def call(mode)
    case mode
    when 1
      mode_1
    when 2
      mode_2
    end
  end

  private

  def mode_1
    branch_name = "develop"
    puts @pastel.black("==> mygit: Working on #{targetdir} (mode 1)")
    git "branch #{branch_name}"
    git "checkout #{branch_name}"
    step_1a
    step_1b
    git "push --set-upstream origin #{branch_name}"
    git "push"
  end

  def step_1a
    copy "step.1a"
    add(".")
    commit "[N] Creando esquema inicial"
  end

  def step_1b
    copy "step.1b"
    add(".")
    commit "[N] Se añade el fichero .gitignore"
  end

  def mode_2
    branch_name = "develop"
    puts @pastel.black("==> mygit: Working on #{targetdir} (mode 2)")
    git "branch #{branch_name}"
    git "checkout #{branch_name}"
    step_2
    git "push --set-upstream origin #{branch_name}"
    git "push"
  end

  def step_2
    copy "step.2"
    add(".")
    commit "[N] Se añaden los ficheros README.md y .gitignore"
  end

  def add(options)
    puts @pastel.black("==> mygit: add #{options}")
    cmd = "git -C #{targetdir} add #{options}"
    ok = system(cmd)
    unless ok
      puts @pastel.red("    [ERROR] #{cmd}")
      exit 1
    end
  end

  def commit(message)
    puts @pastel.black("==> mygit: commit #{message}")
    cmd = "git -C #{targetdir} commit -m \"#{message}\""
    ok = system(cmd)
    unless ok
      puts @pastel.red("    [ERROR] #{cmd}")
    end
  end

  def copy(dirname)
    puts @pastel.black("==> mygit: copy #{dirname}")
    dirpath = File.join(sourcedir, dirname)
    files = Dir.glob("#{dirpath}/*")
    files += Dir.glob("#{dirpath}/.?*")
    FileUtils.cp_r(files.sort, targetdir)
  end

  def git(options)
    puts @pastel.black("==> mygit: #{options}")
    cmd = "git -C #{targetdir} #{options}"
    ok = system(cmd)
    unless ok
      if $?.exitstatus == 128
        puts @pastel.yellow("    [WARN ] #{cmd}")
      else
        puts @pastel.red("    [ERROR] #{cmd}")
      end
    end
  end
end
