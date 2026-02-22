class Init
  attr_reader :dirpath

  def initialize(dirpath)
    @dirpath = File.absolute_path(dirpath)
  end
end
