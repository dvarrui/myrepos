namespace :devel do
  desc "Create /usr/local/bin/mymygit"
  task :launcher do
    launcherpath = "/usr/local/bin/mymygit"
    if File.exist?(launcherpath)
      warn "File exist! (#{launcherpath})"
      exit 1
    end

    rubypath = `rbenv which ruby`.strip
    teutonpath = File.join(Dir.pwd, "mygit")

    puts "# Created with: 'rake devel:launcher'"
    puts "# - Copy this content into: #{launcherpath}"
    puts "# - Then: chmod +x #{launcherpath}"
    puts "RUBYPATH=#{rubypath}"
    puts "CMDPATH=#{teutonpath}"
    puts "$RUBYPATH $CMDPATH $@"
  end

  desc "Delete configuration files"
  task :clean do
    system("rm -r mygit.d")
  end
end
