require 'fileutils'
require 'json'
require_relative '../lib/const'
require_relative '../lib/convenience_functions'
require_relative '../lib/package'
require_relative '../lib/package_utils'

class Command
  def self.remove(pkg, verbose: false, force: false)
    device_json = JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'))

    # Make sure the package is actually installed before we attempt to remove it.
    unless PackageUtils.installed?(pkg.name)
      puts "Package #{pkg.name} isn't installed.".lightred
      return
    end

    # Do not remove any packages in CREW_ESSENTIAL_PACKAGES, as those are needed for ruby and thus crew to run.
    # CREW_ESSENTIAL_PACKAGES is nil if overriding package upgrade list...
    return if CREW_ESSENTIAL_PACKAGES.nil?
    if CREW_ESSENTIAL_PACKAGES.include?(pkg.name) && !force
      # Exit with failure if attempt to remove an essential package
      # is made.
      abort <<~ESSENTIAL_PACKAGE_WARNING_EOF.gsub(/^(?=\w)/, '  ').chomp.lightred
        #{pkg.name.capitalize} is considered an essential package needed for
        Chromebrew to function and thus cannot be removed.
      ESSENTIAL_PACKAGE_WARNING_EOF
    end

    # Check whether the removal breaks dependency of other installed packages
    unless force
      pkgs_that_need_it = []

      device_json['installed_packages'].each do |installed_pkg_info|
        pkg_file      = File.join(CREW_PACKAGES_PATH, "#{installed_pkg_info['name']}.rb")
        installed_pkg = Package.load_package(pkg_file)

        pkgs_that_need_it << installed_pkg.name if installed_pkg.dependencies.key?(pkg.name)
      end

      if pkgs_that_need_it.any?
        abort <<~EOT.chomp.lightred
          #{pkg.name.capitalize} is required by the following installed packages:

            #{pkgs_that_need_it.join("\n  ")}

          Use `crew remove --force` if you meant to remove it.
        EOT
      end
    end

    # Perform any operations required prior to package removal.
    pkg.preremove

    # Use gem to first try to remove gems...
    if pkg.name.start_with?('ruby_')
      @ruby_gem_name = pkg.name.sub('ruby_', '').sub('_', '-')
      if Kernel.system "gem list -i \"^#{@ruby_gem_name}\$\"", %i[out err] => File::NULL
        puts "Uninstalling #{@ruby_gem_name} before removing gem files. It's ok if this fails.".orange
        system "gem uninstall -aIx --abort-on-dependent #{@ruby_gem_name}", exception: false
      end
    end

    # Use pip to first try to remove python packages if package uses pip.
    if pkg.name.start_with?('py3_')
      pkg_file = Dir["{#{CREW_LOCAL_REPO_ROOT}/packages,#{CREW_PACKAGES_PATH}}/#{pkg.name}.rb"].max { |a, b| File.mtime(a) <=> File.mtime(b) }
      system "python3 -s -m pip uninstall #{pkg.name.gsub('py3_', '')} -y", exception: false if Kernel.system "grep -q \"^require 'buildsystems/pip\" #{pkg_file}"
    end

    # Remove the files and directories installed by the package.
    unless pkg.is_fake?
      Dir.chdir CREW_CONFIG_PATH do
        # Remove all files installed by the package in CREW_PREFIX and HOME.
        #
        # Exceptions:
        # 1. The file exists in another installed package.
        filelist_path = File.join(CREW_META_PATH, "#{pkg.name}.filelist")
        if File.file?(filelist_path)
          filelist                = File.readlines(filelist_path, chomp: true)
          overlap_files           = ConvenienceFunctions.determine_conflicts(pkg.name, filelist_path, verbose: verbose)
          # essential_files should only contain filelists for packages already installed.
          essential_files         = CREW_ESSENTIAL_PACKAGES.flat_map { |f| File.readlines(File.join(CREW_META_PATH, "#{f}.filelist"), chomp: true) if File.file?(File.join(CREW_META_PATH, "#{f}.filelist")) }
          overlap_essential_files = filelist & essential_files
          files_to_remove         = filelist - overlap_files.values.flatten - overlap_essential_files

          if overlap_essential_files.any?
            warn "The following file(s) will not be deleted as they are required for Chromebrew to work properly:\n".orange
            warn overlap_essential_files.join("\n").orange
            warn "\n\n"
          end

          if overlap_files.any?
            warn "The following file(s) in other packages will not be deleted during the removal of #{pkg.name}:\n".orange
            overlap_files.each_pair do |pkg_name, files|
              files.each { |file| puts "#{pkg_name}: #{file}".orange }
            end
            puts
          end

          files_to_remove.each do |file|
            puts "Removing file #{file}".yellow if verbose
            FileUtils.remove_file file, exception: false
          end

          FileUtils.remove_file filelist_path
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
    ConvenienceFunctions.save_json(device_json)

    # Perform any operations required after package removal.
    pkg.postremove

    puts "#{pkg.name} removed!".lightgreen
  end
end
