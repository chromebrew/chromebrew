require_relative '../lib/const'
require_relative '../lib/package'
require_relative '../lib/package_utils'

class Command
  def self.whatdepends(pkg)
    pkg_count = 0
    puts "#{pkg.lightgreen} is a dependency of:"
    `grep -lER "depends_on '#{pkg}'" #{CREW_PACKAGES_PATH}/*.rb`.lines(chomp: true).flat_map do |result|
      pkg_name = File.basename(result, '.rb')
      if PackageUtils.compatible?(Package.load_package(File.join(CREW_PACKAGES_PATH, "#{pkg_name}.rb")))
        if PackageUtils.installed?(pkg_name)
          puts pkg_name.lightgreen
        else
          puts pkg_name.lightblue
        end
      else
        puts pkg_name.lightred
      end
      pkg_count += 1
    end

    if pkg_count.zero?
      puts "Total found: #{pkg_count}\n".lightred
    else
      puts "Total found: #{pkg_count}\n".lightgreen
    end
  end
end
