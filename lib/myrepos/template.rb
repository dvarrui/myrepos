
module MyRepos
  class Template
    def initialize(name)
      load
      @name = name
      @pastel = Pastel.new
    end

    def call
      if @name==:list
        self.list
      end
    end

    def list
      puts "Template list:"
      @templates.each { puts " - #{@pastel.blue.bold(it[:name])}" }
    end

    private

    def load
      dirpath = File.join(File.dirname(__FILE__), "files", "templates")
      @dirpath = File.absolute_path(dirpath)
      @templates = Dir.glob(File.join(@dirpath, "*")).map do
        {
          path: it,
          name: File.basename(it)
        }
      end
    end
  end
end
