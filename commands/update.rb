require 'json'
require_relative '../lib/color'
require_relative '../lib/const'
require_relative '../lib/package'
require_relative '../lib/package_utils'

class Command
  def self.update(last_update_check)
    unless Dir.exist?(File.join(CREW_LIB_PATH, '.git'))
      puts 'Fixing Chromebrew system git repo clone...'.orange
      system(<<~GIT_REPAIR_COMMANDS, chdir: CREW_LIB_PATH, %i[out err] => File::NULL)
        ## Run the git setup commands used in install.sh.
        # Make the git default branch error messages go away.
        git config --global init.defaultBranch main
        # Setup the dir with git information.
        git init --ref-format=reftable
        git remote add origin #{CREW_REPO}
        # Help handle situations where GitHub is down.
        git config --local http.lowSpeedLimit 1000
        git config --local http.lowSpeedTime 5
        # Checkout, overwriting local files.
        git fetch --all
        git checkout -f master
        git reset --hard origin/#{CREW_BRANCH}
      GIT_REPAIR_COMMANDS
    end

    # Update crew from git.
    # Set sparse-checkout folders.
    system "git sparse-checkout set packages manifest/#{ARCH} lib commands bin crew tests tools", chdir: CREW_LIB_PATH, exception: true
    system 'git sparse-checkout reapply', chdir: CREW_LIB_PATH, exception: true
    system "git fetch #{CREW_REPO} #{CREW_BRANCH}", chdir: CREW_LIB_PATH, exception: true
    # Now that we've fetched all the new changes, see if lib/const.rb was changed.
    # We do this before resetting to FETCH_HEAD because we lose the original HEAD when doing so.
    to_update = `cd #{CREW_LIB_PATH} && git show --name-only HEAD..FETCH_HEAD`.include?('lib/const.rb')
    system('git reset --hard FETCH_HEAD', chdir: CREW_LIB_PATH, exception: true)

    if Time.now.to_i - last_update_check > (CREW_UPDATE_CHECK_INTERVAL * 3600 * 24)
      puts 'Updating RubyGems.'.orange
      system 'gem update -N --system'
      system 'gem cleanup'
    end

    puts 'Package lists, crew, and library updated.'

    # If lib/const.rb was changed, CREW_VERSION was bumped, so we re-run crew update.
    if to_update
      puts 'Restarting crew update since there is an updated crew version.'.lightcyan
      puts "CREW_REPO=#{CREW_REPO} CREW_BRANCH=#{CREW_BRANCH} crew update".orange if CREW_VERBOSE
      exec "CREW_REPO=#{CREW_REPO} CREW_BRANCH=#{CREW_BRANCH} crew update"
    end

    # Do any fixups necessary after crew has updated from git.
    system "#{CREW_LIB_PATH}/lib/fixup.rb"

    # check for outdated installed packages
    puts 'Checking for package updates...'
    can_be_updated = determine_updatable_packages

    if can_be_updated.positive?
      puts "\n#{can_be_updated} packages can be updated."
      puts 'Run `crew upgrade` to update all packages or `crew upgrade <package1> [<package2> ...]` to update specific packages.'
    else
      puts 'Your software is up to date.'.lightgreen
    end
  end
end

def determine_updatable_packages(json: false)
  can_be_updated = 0
  updatable_packages = []
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
        updatable_packages.push(updated_package.name)
        puts "#{updated_package.name} has a version change but does not have updated binaries".yellow unless json
      end
    elsif different_version
      updatable_packages.push(updated_package.name)
      puts "#{updated_package.name} could be updated from #{installed_package['version']} to #{updated_package.version}" unless json
    elsif !different_version && different_sha
      updatable_packages.push(updated_package.name)
      puts "#{updated_package.name} could be updated (rebuild)" unless json
    end
  end

  return json ? updatable_packages : can_be_updated
end
