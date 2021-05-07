module DependencyUtils
  def expand_dependencies (debug: false)
    @checking = Array.new

    def push_dependencies
      if @pkg.is_binary?(@device[:architecture]) or \
        !@pkg.in_upgrade and \
        !@pkg.build_from_source
    
        # retrieve name of dependencies that doesn't contain :build tag
        check_deps = @pkg.dependencies \
          .reject {|k, v| v.include?(:build)} \
          .map {|k, v| k}
      else
        # retrieve name of all dependencies
        check_deps = @pkg.dependencies.map {|k, v| k}
      end
      # check all dependencies recursively
      check_deps.each do |dep|
        # build unique dependencies list
        unless @dependencies&.include?(dep) or \
               dep == @pkgName or \
               @checking&.include?(dep) or \
               installed?(dep)

          search dep, true
          @checking << @pkg.name
          push_dependencies
          @dependencies << dep
        end
      end
    end
    push_dependencies
    remove_instance_variable(:@checking)
  end
end
