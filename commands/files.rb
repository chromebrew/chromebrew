require_relative '../lib/const'
require_relative '../lib/convenience_functions'
require_relative '../lib/misc_functions'
require_relative '../lib/package_utils'

class Command
  def self.files(pkg)
    # Fake packages do not have any files.
    if pkg.is_fake?
      puts "Package #{pkg.name} is fake and has no files.".lightred
      return
    end

    # We can't do anything if we don't have the filelist.
    filelist_path = File.join("#{CREW_LIB_PATH}/manifest/#{ARCH}/#{pkg.name[0]}/", "#{pkg.name}.filelist")
    puts "Manifest file: #{filelist_path}".yellow if CREW_VERBOSE
    unless File.file?(filelist_path)
      if PackageUtils.compatible?(pkg)
        puts "Package #{pkg.name} does not have a filelist but should since #{ARCH} is compatible. :(".lightred
      else
        puts "Package #{pkg.name} does not have a filelist since #{ARCH} is not compatible. :(".lightred
      end
      return
    end

    # Installed packages have green names, incompatible packages have red, and compatible but not installed have blue.
    if PackageUtils.installed?(pkg.name)
      print pkg.name.lightgreen
    elsif !PackageUtils.compatible?(pkg)
      print pkg.name.lightred
    else
      print pkg.name.lightblue
    end
    puts ": #{pkg.description}".lightblue

    # Extract the filelist and the total size of those files.
    filesize, filelist = ConvenienceFunctions.read_filelist(filelist_path)

    # Print the filelist, the total number of files, and the total size of those files.
    puts filelist
    puts "\nTotal found: #{filelist.count - 1}".lightgreen
    puts "Disk usage: #{MiscFunctions.human_size(filesize)}".lightgreen
  end
end
