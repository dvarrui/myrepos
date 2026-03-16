module MyRepos
  class LocalRepo
    def initialize(basedir)
      @basedir = basedir
    end
  end

  def show
    puts "LocalRepo: #{@basedir}"
  end
end