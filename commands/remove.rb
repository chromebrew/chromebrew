require 'fileutils'
require 'json'
require_relative '../lib/const'

class Command
  def self.remove(pkg, verbose)
    device_json = JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'))

    # Make sure the package is actually installed before we attempt to remove it.
    if device_json['installed_packages'].none? { |entry| entry['name'] == pkg.name }
      puts "Package #{pkg.name} isn't installed.".lightred
      return
    end

    # Don't remove any of the packages ruby (and thus crew) needs to run.
    if %w[gcc_lib glibc gmp ruby zlibpkg zstd].include?(pkg.name)
      puts "Refusing to remove essential package #{pkg.name}.".lightred
      return
    end

    # We can't remove a package if we don't have the filelist.
    unless File.file?(File.join(CREW_META_PATH, "#{pkg.name}.filelist"))
      puts "Unable to remove package #{pkg.name} as it does not have a filelist.".lightred
      return
    end

    # Perform any operations required prior to package removal.
    pkg.preremove

    # Remove the files and directories installed by the package.
    Dir.chdir CREW_CONFIG_PATH do
      # Remove all files installed by the package.
      File.foreach(File.join(CREW_META_PATH, "#{pkg.name}.filelist"), chomp: true) do |line|
        next unless line.start_with?(CREW_PREFIX)
        if system("grep --exclude #{pkg.name}.filelist -Fxq #{line} ./meta/*.filelist")
          puts "#{line} is in another package. It will not be removed during the removal of #{pkg.name}.".orange
        else
          puts "Removing file #{line}".yellow if verbose
          FileUtils.remove_file line, exception: false
        end
      end

      # Remove all directories installed by the package.
      File.foreach(File.join(CREW_META_PATH, "#{pkg.name}.directorylist"), chomp: true) do |line|
        next unless Dir.exist?(line) && Dir.empty?(line) && line.include?(CREW_PREFIX)
        puts "Removing directory #{line}".yellow if verbose
        FileUtils.remove_dir line, exception: false
      end

      # Remove the file and directory lists.
      FileUtils.remove_file File.join(CREW_META_PATH, "#{pkg.name}.filelist")
      FileUtils.remove_file File.join(CREW_META_PATH, "#{pkg.name}.directorylist")
    end

    # Remove the package from the list of installed packages in device.json.
    puts "Removing package #{pkg_name} from device.json".yellow if verbose
    device_json['installed_packages'].delete_if { |entry| entry['name'] == pkg.name }

    # Update device.json with our changes.
    File.write File.join(CREW_CONFIG_PATH, 'device.json'), JSON.pretty_generate(JSON.parse(device_json.to_json))

    # Perform any operations required after package removal.
    pkg.remove

    puts "#{pkg.name} removed!".lightgreen
  end
end
