require 'fileutils'
require 'json'
require_relative '../lib/const'
require_relative '../lib/package'
require_relative '../lib/package_utils'

class Command
  def self.remove(pkg, verbose)
    device_json = JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'))

    # Make sure the package is actually installed before we attempt to remove it.
    unless PackageUtils.installed?(pkg.name)
      puts "Package #{pkg.name} isn't installed.".lightred
      return
    end

    # Determine dependencies of packages in CREW_ESSENTIAL_PACKAGES and
    # their dependencies, as those are needed for ruby and crew to run,
    # and thus should not be removed.
    # essential_deps = recursive_deps(CREW_ESSENTIAL_PACKAGES)
    essential_deps = device_json[:essential_deps]
    crewlog "Essential Deps are #{essential_deps}."
    if essential_deps.include?(pkg.name)
      return if pkg.in_upgrade

      puts <<~ESSENTIAL_PACKAGE_WARNING_EOF.gsub(/^(?=\w)/, '  ').lightred
        #{pkg.name.capitalize} is considered an essential package needed for
        Chromebrew to function and thus cannot be removed.
      ESSENTIAL_PACKAGE_WARNING_EOF

      return
    end

    # Perform any operations required prior to package removal.
    pkg.preremove

    # Use gem to first try to remove gems...
    if pkg.name.start_with?('ruby_')
      @gem_name = pkg.name.sub('ruby_', '').sub('_', '-')
      if Kernel.system "gem list -i \"^#{@gem_name}\$\""
        puts "Uninstalling #{@gem_name} before updating. It's ok if this fails.".orange
        system "gem uninstall -aIx --abort-on-dependent #{@gem_name}", exception: false
      end
    end

    # Remove the files and directories installed by the package.
    unless pkg.is_fake?
      Dir.chdir CREW_CONFIG_PATH do
        # Remove all files installed by the package in CREW_PREFIX and
        # HOME.
        # Exceptions:
        # 1. The file exists in another installed package.
        # 2. The file is in one of the filelists for packages in
        # CREW_ESSENTIAL_FILES, or a dependendent package of
        # CREW_ESSENTIAL_PACKAGES.
        flist = File.join(CREW_META_PATH, "#{pkg.name}.filelist")
        if File.file?(flist)
          # When searching for files to delete we exclude the files from
          # all packages and dependent packages of CREW_ESSENTIAL_PACKAGES.
          essential_deps_exclude_froms = essential_deps.map { |i| File.file?("#{File.join(CREW_META_PATH, i.to_s)}.filelist") ? "--exclude-from=#{File.join(CREW_META_PATH, i.to_s)}.filelist" : '' }.join(' ')

          # When making a list of all files from crew filelists we again
          # ignore all files from packages and dependent packages of
          # CREW_ESSENTIAL_PACKAGES.
          essential_deps_excludes = essential_deps.map { |i| File.file?("#{File.join(CREW_META_PATH, i.to_s)}.filelist") ? "--exclude=#{File.join(CREW_META_PATH, i.to_s)}.filelist" : '' }.join(' ')

          package_files = `grep -h #{essential_deps_exclude_froms} \"^#{CREW_PREFIX}\\|^#{HOME}\" #{flist}`.split("\n").uniq.sort
          all_other_files = `grep -h --exclude #{pkg.name}.filelist #{essential_deps_excludes} \"^#{CREW_PREFIX}\\|^#{HOME}\" #{CREW_META_PATH}/*.filelist`.split("\n").uniq.sort

          # We want the difference of these arrays.
          unique_to_package_files = package_files - all_other_files

          # We want the intersection of these arrays.
          package_files_that_overlap = all_other_files & package_files

          unless package_files_that_overlap.empty?
            puts "The following file(s) in other packages will not be deleted during the removal of #{pkg.name}:".orange
            puts package_files_that_overlap.join("\n").orange
          end
          unique_to_package_files.each do |file|
            puts "Removing file #{file}".yellow if CREW_VERBOSE
            FileUtils.remove_file file, exception: false
          end
          FileUtils.remove_file flist
        end

        # Remove all directories installed by the package.
        dlist = File.join(CREW_META_PATH, "#{pkg.name}.directorylist")
        if File.file?(dlist)
          File.foreach(dlist, chomp: true) do |line|
            next unless Dir.exist?(line) && Dir.empty?(line) && line.include?(CREW_PREFIX)
            puts "Removing directory #{line}".yellow if verbose
            FileUtils.remove_dir line, exception: false
          end
          FileUtils.remove_file dlist
        end
      end
    end

    # Remove the package from the list of installed packages in device.json.
    puts "Removing package #{pkg.name} from device.json".yellow if verbose
    device_json['installed_packages'].delete_if { |entry| entry['name'] == pkg.name }

    # Update device.json with our changes.
    save_json(device_json)

    # Perform any operations required after package removal.
    pkg.postremove

    puts "#{pkg.name} removed!".lightgreen
  end
end
