require_relative '../lib/const'
require_relative '../lib/package'
require_relative '../lib/package_utils'

class Command
  def self.whatdepends(pkg)
    require 'json' if CREW_OUTPUT_JSON
    pkg_count = 0
    depends = []
    puts "#{pkg.lightgreen} is a dependency of:" unless CREW_OUTPUT_JSON
    `grep -lER "depends_on '#{pkg}'" #{CREW_PACKAGES_PATH}/*.rb`.lines(chomp: true).flat_map do |result|
      pkg_name = File.basename(result, '.rb')
      if PackageUtils.compatible?(Package.load_package(File.join(CREW_PACKAGES_PATH, "#{pkg_name}.rb")))
        depends.push(pkg_name)
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

    puts depends.to_json if CREW_OUTPUT_JSON
    if pkg_count.zero?
      puts "Total found: #{pkg_count}\n".lightred unless CREW_OUTPUT_JSON
    else
      puts "Total found: #{pkg_count}\n".lightgreen unless CREW_OUTPUT_JSON
    end
  end
end
