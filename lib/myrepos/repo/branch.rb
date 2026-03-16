module MyRepos
  class Branch
    attr_reader :all
    attr_reader :current

    def initialize(repopath)
      @repopath = repopath
      load
    end

    private

    def load
      load_all_branches
      load_current_branch
    end

    def load_all_branches 
        # Ejecutamos git branch dentro del directorio especificado
        # --format='%(refname:short)' nos da solo el nombre (ej: 'main', 'develop')
        # 2>&1 redirige errores al output para que no ensucien la consola
        output = `git -C "#{@repopath}" branch --format='%(refname:short)' 2>&1`
        @all = output.split("\n").map(&:strip)
      end
      
      def load_current_branch
        @current = `git -C "#{@repopath}" rev-parse --abbrev-ref HEAD 2>/dev/null`.strip
      end
  end
end