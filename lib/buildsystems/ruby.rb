require_relative '../color'
require_relative '../package'
require_relative '../package_utils'
require_relative '../report_buildsystem_methods'
require_relative '../require_gem'

def check_gem_binary_build_needed(ruby_gem_name = nil, ruby_gem_version = nil)
  puts "Checking to see if gem compile for #{ruby_gem_name} is needed..."
  @extract_dir = "#{ruby_gem_name}.#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.dir"
  FileUtils.mkdir_p File.join(CREW_BREW_DIR, @extract_dir)
  Dir.chdir(File.join(CREW_BREW_DIR, @extract_dir)) do
    # Need to check if the gem has extensions. If it does, we need
    # either a compiler or a pre-compiled binary gem.
    system "gem fetch #{ruby_gem_name} --platform=ruby --version=#{ruby_gem_version}"
    system "gem unpack #{ruby_gem_name}-#{ruby_gem_version}.gem"
    system "grep -q -r spec.extensions  #{ruby_gem_name}-#{ruby_gem_version}/*.gemspec", exception: false, %i[out err] => File::NULL
    @build_needed = system "grep -q -r spec.extensions  #{ruby_gem_name}-#{ruby_gem_version}/*.gemspec", %i[out err] => File::NULL
  end
  FileUtils.rm_rf File.join(CREW_BREW_DIR, @extract_dir)
  return @build_needed
end

def save_gem_filelist(gem_name = nil, gem_version = nil, gem_filelist_path = nil)
  gem_filelist_path = File.join(CREW_META_PATH, "ruby_#{gem_name.gsub('-', '_')}.filelist") if gem_filelist_path.nil?
  crewlog "@gem_latest_version_installed: #{@gem_latest_version_installed}"
  # Skip if in reinstall or upgrade, as the install hasn't happened yet.
  # return if @pkg.in_upgrade
  # We need the gem reinstalled, so we don't use --conservative, which
  # avoids the reinstall.
  files = `gem contents #{gem_name}`.chomp.split
  if [`gem list --no-update-sources -l -e #{gem_name}`.chomp.to_s].grep(/#{gem_name}/)[0] && !files.blank?
    # Gem is already installed.
    crewlog "#{gem_name} is already installed."
  elsif File.file?("#{CREW_DEST_DIR}/#{gem_name}-#{gem_version}-#{GEM_ARCH}.gem")
    # Gem not installed but a binary for the gem exists.
    crewlog "#{gem_name} not installed, but a binary exists."
    Kernel.system "gem install --no-update-sources -N --local #{CREW_DEST_DIR}/#{gem_name}-#{gem_version}-#{GEM_ARCH}.gem --conservative &>/dev/null"
  else
    crewlog "#{gem_name} is not installed"
    Kernel.system "gem install --no-update-sources -N #{gem_name} &>/dev/null"
  end
  files = `gem contents #{gem_name}`.chomp.split
  if files.blank?
    puts "Filelist is blank for #{gem_name}".lightred
    return
  end

  exes = files.grep(%r{/exe/|/bin/})
  # Gem.bindir should end up being #{CREW_PREFIX}/bin.
  exes&.map! { |x| x.gsub(%r{^.*(/exe/|/bin/)}, "#{Gem.bindir}/") }
  filelist = (files + exes).sort.uniq
  # Create file list and calculate file size (modified from the one
  # used in crew.)
  filelist = filelist.select do |e|
    File.file?(e) || File.symlink?(e)
  end.to_h do |e|
    # Ignore symlinks to prevent duplicating calculation.
    ["/#{e[1..]}", File.symlink?(e) ? 0 : File.size(e)]
  end

  # If the package is completely empty, something has probably gone wrong.
  total_size = filelist.values.sum
  abort 'total_size is 0. It seems that no files were installed.'.lightred if total_size.zero?

  File.write gem_filelist_path, <<~EOF
    # Total size: #{total_size}
    #{filelist.keys.sort.join("\n")}
  EOF
  local_filelist = File.join(CREW_LOCAL_REPO_ROOT, 'manifest', ARCH, name[0].to_s, "#{name}.filelist")
  FileUtils.mkdir_p File.join(CREW_LOCAL_REPO_ROOT, 'manifest', ARCH, name[0].to_s)
  FileUtils.cp gem_filelist_path, local_filelist
  puts "Copied #{gem_filelist_path} to #{local_filelist}".lightpurple if CREW_VERBOSE || ENV['NESTED_CI']
end

def add_gem_binary_compression(pkg_name = nil)
  pkg_file = File.join(CREW_PACKAGES_PATH, "#{pkg_name}.rb")
  @gem_pkg = Package.load_package(pkg_file)
  system "sed -i 's/no_compile_needed/gem_compile_needed/' #{pkg_file}"
  binary_compression_not_in_file = @gem_pkg.binary_compression.nil?
  if binary_compression_not_in_file
    binary_compression = @gem_pkg.superclass.to_s == 'RUBY' ? 'gem' : 'tar.zst'
    binary_compression_line = "  binary_compression '#{binary_compression}'"
    # 2b. Add missing binary_compression value to file.
    puts "Setting binary compression in #{pkg_file} to '#{binary_compression}'..."
    file = File.read(pkg_file)
    bc_re = /^\ \ binary_compression.*/
    source_re = /^\ \ source_sha256.*/
    git_hashtag_re = /^\ \ git_hashtag.*/
    source_url_re = /^\ \ source_url.*/
    if file.match(bc_re)
      File.write(pkg_file, file.gsub(bc_re, binary_compression_line))
    elsif file.match(source_re)
      source_sha256_bc_line = "#{file.match(source_re)}\n#{binary_compression_line}"
      File.write(pkg_file, file.gsub(source_re, source_sha256_bc_line))
    elsif file.match(git_hashtag_re)
      git_hashtag_bc_line = "#{file.match(git_hashtag_re)}\n#{binary_compression_line}"
      File.write(pkg_file, file.gsub(git_hashtag_re, git_hashtag_bc_line))
    elsif file.match(source_url_re)
      source_url_bc_line = "#{file.match(source_url_re)}\n#{binary_compression_line}"
      File.write(pkg_file, file.gsub(source_url_re, source_url_bc_line))
    else
      puts "Unable to tell where to add \"#{binary_compression_line}\" to #{pkg_file}. Please add it and manually.".lightblue
    end
  end
end

def check_and_install_gem_deps(gem_name = nil, gem_version = nil)
  unless @gem_deps.blank?
    puts 'Dependencies:'.orange
    puts @gem_deps
    @gem_deps.each do |gem_dep|
      gem_dep = "ruby_#{gem_dep.gsub('-', '_')}"
      if File.file?(File.join(CREW_PACKAGES_PATH, "#{gem_dep}.rb"))
        crewlog "#{gem_dep.capitalize} package exists."
        install_pkg = Package.load_package("packages/#{gem_dep}.rb")
        installed_gem_search = [`gem list --no-update-sources -l -e #{gem_name}`.chomp.to_s].grep(/#{gem_name}/)[0]
        if installed_gem_search
          installed_gem_info = installed_gem_search.delete('()').gsub('default:', '').gsub(',', '').split
          gem_installed_version = installed_gem_info[1]
          (Gem::Version.new(gem_version) > Gem::Version.new(gem_installed_version))
          gem_latest_version_installed = Gem::Version.new(gem_version) <= Gem::Version.new(gem_installed_version)
        else
          gem_latest_version_installed = false
        end
        crewlog "#{install_pkg.name}: PackageUtils.installed?(install_pkg.name): #{PackageUtils.installed?(install_pkg.name)} gem_latest_version_installed: #{gem_latest_version_installed}"
        if PackageUtils.installed?(install_pkg.name) && gem_latest_version_installed
          crewlog "Current version of #{gem_dep.capitalize} installed."
        else
          install_pkg = Package.load_package("packages/#{gem_dep}.rb")
          crewlog "#{install_pkg.name} installed".orange if PackageUtils.installed?(install_pkg.name)
          system("yes | crew install #{gem_dep}")
        end
      else
        puts "Will not install #{gem_dep} from a Chromebrew package, as one does not exist.".orange
      end
    end
  end
end

class RUBY < Package
  property :ruby_gem_name, :ruby_gem_version, :ruby_install_extras

  depends_on 'ruby'

  def self.preflight
    @install_gem ||= true
    @ruby_gem_name, @ruby_gem_version, @remote_ruby_gem_version, @gem_installed_version, @gem_latest_version_installed, @gem_outdated, @gem_deps = PackageUtils.get_gem_vars(name, version, Package.load_package(File.join(CREW_PACKAGES_PATH, "#{name}.rb")).upstream_name)
    puts "Examining #{@ruby_gem_name} gem...".orange
    @gem_filelist_path = File.join(CREW_META_PATH, "#{name}.filelist")

    # Check for gem dependencies before installing, in case those gems
    # already have packages or binary packages, so we can avoid
    # compiling those on end-user devices.
    check_and_install_gem_deps(@ruby_gem_name, @ruby_gem_version)

    # Create a filelist from the gem if the latest gem version is
    # installed.
    crewlog "@gem_latest_version_installed for #{@ruby_gem_name} is #{@gem_latest_version_installed}"
    save_gem_filelist(@ruby_gem_name, @ruby_gem_version, @gem_filelist_path) if @gem_latest_version_installed

    # If the version number gem reports isn't newer than the version
    # number that Chromebrew has recorded, force an install.
    # Otherwise we can skip the install and bail.
    @device = ConvenienceFunctions.load_symbolized_json
    pkg_info = @device[:installed_packages].select { |pkg| pkg[:name] == name }[0]
    return if pkg_info.nil?

    # Handle case of the Chromebrew gem pkg not yet having been
    # installed or having a changed version number despite the gem
    # having been installed.
    @json_gem_pkg_version = pkg_info[:version].gsub!('_', '-').to_s
    if Gem::Version.new(@ruby_gem_version) <= Gem::Version.new(@json_gem_pkg_version)
      crewlog "#{name}: #{@ruby_gem_version} <= #{@json_gem_pkg_version}, setting @install_gem to false"
      @install_gem = false
    end
  end

  def self.preinstall
    @gem_binary_build_needed = check_gem_binary_build_needed(@ruby_gem_name, @ruby_gem_version) unless no_compile_needed? || gem_compile_needed?
  end

  def self.build
    return unless !no_compile_needed? || @gem_binary_build_needed

    extend ReportBuildsystemMethods

    print_buildsystem_methods

    Kernel.system "gem fetch #{@ruby_gem_name} --platform=ruby --version=#{@ruby_gem_version}"
    Kernel.system "gem unpack #{@ruby_gem_name}-#{@ruby_gem_version}.gem"
    system 'gem install --no-update-sources -N gem-compiler --conservative' unless Kernel.system('gem compile --help 2>/dev/null', %i[out err] => File::NULL)
    system "gem compile --strip --prune #{@ruby_gem_name}-#{@ruby_gem_version}.gem -O #{CREW_DEST_DIR}/ -- --build-flags --with-cflags='#{CREW_LINKER_FLAGS}' --with-ldflags='#{CREW_LINKER_FLAGS}'"
    @just_built_gem = true
  end

  def self.install
    # @install_gem will always be true during upgrades since we remove
    # the old gem during the upgrade.
    @ruby_gem_name, @ruby_gem_version, @remote_ruby_gem_version, @gem_installed_version, @gem_latest_version_installed, @gem_outdated, @gem_deps = PackageUtils.get_gem_vars(name, version, Package.load_package(File.join(CREW_PACKAGES_PATH, "#{name}.rb")).upstream_name) if @ruby_gem_name.blank? || @gem_installed_version.blank? || @ruby_gem_version.blank?
    @gem_filelist_path = File.join(CREW_META_PATH, "#{name.downcase}.filelist") if @gem_filelist_path.nil?
    if @gem_installed_version.blank?
      crewlog "@gem_installed_version.blank? is #{@gem_installed_version.blank?}, setting @install_gem = true"
      @install_gem = true if @gem_installed_version.blank?
    end
    unless @install_gem
      puts "#{@ruby_gem_name} #{@gem_installed_version} is properly installed.".lightgreen
      return
    end

    crewlog "no_compile_needed?: #{no_compile_needed?} @gem_binary_build_needed.blank?: #{@gem_binary_build_needed.blank?}, gem_compile_needed?: #{gem_compile_needed?}"
    puts "#{@ruby_gem_name.capitalize} needs a binary gem built!".orange unless @gem_binary_build_needed.blank?
    if !no_compile_needed? || !@gem_binary_build_needed.blank? || gem_compile_needed?
      @gem_pkg = Package.load_package(File.join(CREW_PACKAGES_PATH, "#{name}.rb"))
      gem_pkg_sha256sum = PackageUtils.get_sha256(@gem_pkg)
      if File.file?("#{CREW_DEST_DIR}/#{@ruby_gem_name}-#{@ruby_gem_version}-#{GEM_ARCH}.gem")
        gem_sha256 = `sha256sum #{CREW_DEST_DIR}/#{@ruby_gem_name}-#{@ruby_gem_version}-#{GEM_ARCH}.gem`.chomp.split.first
      else
        system "ls -aFl #{CREW_DEST_DIR}"
        gem_sha256 = nil
      end
      if File.file?("#{CREW_DEST_DIR}/#{@ruby_gem_name}-#{@ruby_gem_version}-#{GEM_ARCH}.gem") && (gem_sha256 == gem_pkg_sha256sum || @just_built_gem)
        puts "Installing #{@ruby_gem_name} gem #{@ruby_gem_version}...".orange
        Kernel.system "gem install --no-update-sources -N --local #{CREW_DEST_DIR}/#{@ruby_gem_name}-#{@ruby_gem_version}-#{GEM_ARCH}.gem --conservative"
      end
    elsif @gem_outdated || Gem::Version.new(@ruby_gem_version) <= Gem::Version.new(@json_gem_pkg_version)
      puts "Updating #{@ruby_gem_name} gem: #{@gem_installed_version} 🔜 #{@ruby_gem_version} ...".orange
      Kernel.system "gem update --no-update-sources -N #{@ruby_gem_name} --conservative"
    elsif !@gem_latest_version_installed
      puts "Installing #{@ruby_gem_name} gem #{@ruby_gem_version}...".orange
      Kernel.system "gem install --no-update-sources -N #{@ruby_gem_name} --conservative"
    end
    # Check gem versions again.
    @ruby_gem_name, @ruby_gem_version, @remote_ruby_gem_version, @gem_installed_version, @gem_latest_version_installed, @gem_outdated, @gem_deps = PackageUtils.get_gem_vars(name, version, Package.load_package(File.join(CREW_PACKAGES_PATH, "#{name}.rb")).upstream_name)
    @gems_needing_cleanup = Array(@gems_needing_cleanup) << @ruby_gem_name unless @gem_latest_version_installed
    puts "save_gem_filelist(#{@ruby_gem_name}, #{@ruby_gem_version}, #{@gem_filelist_path})".lightpurple if CREW_VERBOSE
    save_gem_filelist(@ruby_gem_name, @ruby_gem_version, @gem_filelist_path)
    add_gem_binary_compression(name) if File.file?(@gem_filelist_path) && no_compile_needed? && system("grep '.so$' #{@gem_filelist_path}", exception: false)
    @ruby_install_extras&.call
    @install_gem = false
    @just_built_gem = false
  end
end
