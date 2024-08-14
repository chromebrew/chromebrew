require 'fileutils'
require 'json'
require_relative '../lib/const'
require_relative '../lib/package_utils'

class Command
  def self.remove(pkg, verbose)
    device_json = JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'))

    # Make sure the package is actually installed before we attempt to remove it.
    unless PackageUtils.installed?(pkg.name)
      puts "Package #{pkg.name} isn't installed.".lightred
      return
    end

    # Don't remove any of the packages ruby (and thus crew) needs to run.
    if CREW_ESSENTIAL_PACKAGES.include?(pkg.name)
      puts "Refusing to remove essential package #{pkg.name}.".lightred
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
        # HOME unless the file exists in another installed package.
        flist = File.join(CREW_META_PATH, "#{pkg.name}.filelist")
        if File.file?(flist)
          package_files = []
          package_files << `grep -h "^#{CREW_PREFIX}\\|^#{HOME}" #{flist}`.split("\n")
          all_other_files = []
          all_other_files << `grep -h --exclude #{pkg.name}.filelist "^#{CREW_PREFIX}\\|^#{HOME}" #{CREW_META_PATH}/*.filelist`.split("\n")

          unique_to_package_files = package_files - all_other_files
          package_files_that_overlap = all_other_files & package_files

          unless package_files_that_overlap.flatten.empty?
            puts "The following file(s) are in other packages. They will not be deleted during the removal of #{pkg.name}.".orange
            puts package_files_that_overlap.flatten.to_s.orange
          end
          unique_to_package_files.flatten.each do |file|
            if CREW_ESSENTIAL_FILES.include?('file')
              crewlog("Skipping CREW_ESSENTIAL_FILE #{file}")
            else
              puts "Removing file #{file}".yellow if CREW_VERBOSE
              FileUtils.remove_file file, exception: false
            end
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
