require 'json'
require_relative '../lib/color'
require_relative '../lib/const'
require_relative '../lib/package'
require_relative '../lib/package_utils'

class Command
  def self.update
    # Update package lists.
    Dir.chdir(CREW_LIB_PATH) do
      # Set sparse-checkout folders.
      system "git sparse-checkout set packages manifest/#{ARCH} lib commands bin crew tests tools"
      system 'git sparse-checkout reapply'

      system "git fetch #{CREW_REPO} #{CREW_BRANCH}", exception: true
      system 'git reset --hard FETCH_HEAD', exception: true
      system 'git-restore-mtime -sq 2>/dev/null', exception: true if PackageUtils.installed?('git_mestrelion_tools')
    end

    puts 'Package lists, crew, and library updated.'

    # Do any fixups necessary after crew has updated from git.
    load File.join(CREW_LIB_PATH, 'lib', 'fixup.rb')

    # Check for outdated installed packages.
    puts 'Checking for package updates...'

    can_be_updated = 0

    device_json = JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'))
    device_json['installed_packages'].each do |installed_package|
      updated_package = Package.load_package(File.join(CREW_PACKAGES_PATH, "#{installed_package['name']}.rb"))

      different_version = (installed_package['version'] != updated_package.version)
      has_sha = !(PackageUtils.get_sha256(updated_package).to_s.empty? || installed_package['sha256'].to_s.empty?)
      different_sha = has_sha && installed_package['sha256'] != PackageUtils.get_sha256(updated_package)

      can_be_updated += 1 if different_version || different_sha

      if different_version && !different_sha && has_sha
        unless updated_package.no_compile_needed?
          can_be_updated -= 1
          puts "#{updated_package.name} has a version change but does not have updated binaries".yellow
        end
      elsif different_version
        puts "#{updated_package.name} could be updated from #{installed_package['version']} to #{updated_package.version}"
      elsif !different_version && different_sha
        puts "#{updated_package.name} could be updated (rebuild)"
      end
    end

    if can_be_updated.positive?
      puts "\n#{can_be_updated} packages can be updated."
      puts 'Run `crew upgrade` to update all packages or `crew upgrade <package1> [<package2> ...]` to update specific packages.'
    else
      puts 'Your software is up to date.'.lightgreen
    end
  end
end
