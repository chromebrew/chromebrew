class Command
  def self.whatdepends(pkg_names)
    crew_local_repo_root = `git rev-parse --show-toplevel 2> /dev/null`.chomp
    crew_local_repo_root = '../' if crew_local_repo_root.to_s.empty?
    $LOAD_PATH.unshift File.join(crew_local_repo_root, 'lib')
    require 'json' if CREW_OUTPUT_JSON
    # Do json reporting of all packages at end, otherwise report per
    # package.
    json_depends = []
    pkg_names.each do |pkg|
      pkg_count = 0
      puts "#{pkg.lightgreen} is a dependency of:" unless CREW_OUTPUT_JSON
      `grep -lER "depends_on '#{pkg}'" #{File.join(crew_local_repo_root, 'packages/')}/*.rb`.lines(chomp: true).flat_map do |result|
        pkg_name = File.basename(result, '.rb')
        if PackageUtils.compatible?(Package.load_package(File.join("#{crew_local_repo_root}/packages/", "#{pkg_name}.rb")))
          json_depends.push(pkg_name)
          if PackageUtils.installed?(pkg_name)
            puts pkg_name.lightgreen unless CREW_OUTPUT_JSON
          else
            puts pkg_name.lightblue unless CREW_OUTPUT_JSON
          end
        else
          puts pkg_name.lightred unless CREW_OUTPUT_JSON
        end
        pkg_count += 1
      end

      if pkg_count.zero?
        puts "Total found: #{pkg_count}\n".lightred unless CREW_OUTPUT_JSON
      else
        puts "Total found: #{pkg_count}\n".lightgreen unless CREW_OUTPUT_JSON
      end
    end
    puts json_depends.to_json if CREW_OUTPUT_JSON && !json_depends.empty?
  end
end
