module MyRepos
  class LocalRepo
    def initialize(basedir)
      @basedir = basedir
    end

    def to_s
      "LocalRepo: #{@basedir}"
    end
  end
end