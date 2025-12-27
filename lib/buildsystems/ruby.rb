require_relative '../color'
require_relative '../gem_compact_index_client'
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

def gem_info(ruby_gem_name = nil)
  # @ruby_gem_version comes from the set_vars function.
  installed_gem_search = [`gem list --no-update-sources -l -e #{ruby_gem_name}`.chomp.to_s].grep(/#{ruby_gem_name}/)[0]
  if installed_gem_search
    installed_gem_info = installed_gem_search.delete('()').gsub('default:', '').gsub(',', '').split
    @gem_installed_version = installed_gem_info[1]
    @gem_outdated = (Gem::Version.new(@ruby_gem_version) > Gem::Version.new(@gem_installed_version))
    @gem_latest_version_installed = Gem::Version.new(@ruby_gem_version) <= Gem::Version.new(@gem_installed_version)
  else
    # If the current gem being installed is not installed this should
    # be false. This will also handle cases of the current installed
    # gem as per 'gem list' being the same version as the version
    # being upgraded to.
    @gem_latest_version_installed = false
  end
  crewlog "@ruby_gem_version: #{@ruby_gem_version} gem_installed_version: #{@gem_installed_version} @gem_outdated: #{@gem_outdated} @gem_latest_version_installed: #{@gem_latest_version_installed}"
end

def set_vars(passed_name = nil, passed_version = nil)
  # crewlog "Setting gem variables... name: #{passed_name}, version: #{passed_version}"
  # This assumes the package class name starts with 'Ruby_' and
  # version is in the form '(gem version)-ruby-(ruby version)'.
  # For example, name 'Ruby_awesome' and version '1.0.0-ruby-3.3'.

  # Just use the fetcher.suggest_gems_from_name function to figure out
  # proper gem name with the appropriate dashes and underscores.
  if CREW_VERBOSE
    # Voluminous info about the gem fetcher network connection...
    require 'rubygems/request'
    Gem::Request.prepend(Module.new do
      def perform_request(req)
        super.tap { |rsp| p [self, req, rsp] }
      end
    end)
  end
  if $gems.blank?
    puts 'Populating gem information using compact index client...'.lightgreen
    $gems ||= BasicCompactIndexClient.new.gems
    puts 'Done populating gem information.'.lightgreen
  end
  # Parse gem information from compact index, the format for which is
  # here: https://guides.rubygems.org/rubygems-org-compact-index-api/
  # Figure out gem name, noting that there may be dashes and underscores
  # in the name.
  gem_test = $gems.grep(/#{"^#{passed_name.gsub(/^ruby_/, '')}\\s.*$"}/).last.blank? ? $gems.grep(/#{"^\(#{passed_name.gsub(/^ruby_/, '').gsub('_', ')+.(')}\\s\).*$"}/).last : $gems.grep(/#{"^#{passed_name.gsub(/^ruby_/, '')}\\s.*$"}/).last
  abort "Cannot find #{passed_name} gem to install.".lightred if gem_test.blank?
  gem_test_name = gem_test.split.first
  gem_test_versions = gem_test.split[1].split(',')
  # Remove minus prefixed versions, as those have been yanked as per
  # https://guides.rubygems.org/rubygems-org-compact-index-api/
  gem_test_versions.delete_if { |i| i.start_with?('-') }
  # Any version with a letter is considered a prerelease as per
  # https://github.com/rubygems/rubygems/blob/b5798efd348935634d4e0e2b846d4f455582db48/lib/rubygems/version.rb#L305
  gem_test_versions.delete_if { |i| i.match?(/[a-zA-Z]/) }
  gem_test_version = gem_test_versions.map { |v| Gem::Version.new(v) }.max.to_s
  @ruby_gem_name = gem_test_name.blank? ? Gem::SpecFetcher.fetcher.suggest_gems_from_name(passed_name.gsub(/^ruby_/, '')).first : gem_test_name
  @remote_ruby_gem_version = gem_test_name.blank? ? Gem.latest_version_for(@ruby_gem_name).to_s : gem_test_version
  @ruby_gem_version = passed_version.split('-').first.to_s
  @gem_package_ver = @ruby_gem_version.dup
  # Use latest gem version.
  @ruby_gem_version = @remote_ruby_gem_version.to_s if Gem::Version.new(@remote_ruby_gem_version.to_s) > Gem::Version.new(@ruby_gem_version)
end

def save_gem_filelist(gem_name = nil, gem_filelist_path = nil)
  crewlog "@gem_latest_version_installed: #{@gem_latest_version_installed}"
  # We need the gem reinstalled, so we don't use --conservative, which
  # avoids the reinstall.
  files = `gem install --no-update-sources -N #{gem_name} &>/dev/null ; gem contents #{gem_name}`.chomp.split
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

  File.write gem_filelist_path, <<~EOF
    # Total size: #{filelist.values.sum}
    #{filelist.keys.sort.join("\n")}
  EOF
  if Dir.exist?("#{CREW_LOCAL_REPO_ROOT}/manifest") && File.writable?("#{CREW_LOCAL_REPO_ROOT}/manifest")
    FileUtils.mkdir_p "#{CREW_LOCAL_REPO_ROOT}/manifest/#{ARCH}/r"
    FileUtils.cp gem_filelist_path, "#{CREW_LOCAL_REPO_ROOT}/manifest/#{ARCH}/r/ruby_#{gem_name.gsub('-', '_')}.filelist"
  end
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

class RUBY < Package
  property :ruby_gem_name, :ruby_gem_version, :ruby_install_extras

  depends_on 'ruby'

  def self.preflight
    @install_gem ||= true
    set_vars(name, version)
    puts "Examining #{@ruby_gem_name} gem...".orange
    @gem_filelist_path = File.join(CREW_META_PATH, "#{name}.filelist")
    gem_info(@ruby_gem_name)

    # Create a filelist from the gem if the latest gem version is
    # installed.
    save_gem_filelist(@ruby_gem_name, @gem_filelist_path) if @gem_latest_version_installed

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
    @install_gem = false if Gem::Version.new(@ruby_gem_version) <= Gem::Version.new(@json_gem_pkg_version)
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
    set_vars(name, version) if @ruby_gem_name.blank? || @gem_installed_version.blank?
    unless @install_gem
      puts "#{@ruby_gem_name} #{@gem_installed_version} is properly installed.".lightgreen
      return
    end
    gem_info(@ruby_gem_name)

    crewlog "no_compile_needed?: #{no_compile_needed?} @gem_binary_build_needed.blank?: #{@gem_binary_build_needed.blank?}, gem_compile_needed?: #{gem_compile_needed?}"
    puts "#{@ruby_gem_name.capitalize} needs a binary gem built!".orange unless @gem_binary_build_needed.blank?
    if !no_compile_needed? || !@gem_binary_build_needed.blank? || gem_compile_needed?
      @gem_pkg = Package.load_package(File.join(CREW_PACKAGES_PATH, "#{name}.rb"))
      gem_pkg_sha256sum = PackageUtils.get_sha256(@gem_pkg)
      gem_sha256 = `sha256sum #{CREW_DEST_DIR}/#{@ruby_gem_name}-#{@ruby_gem_version}-#{GEM_ARCH}.gem`.chomp.split.first
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
    gem_info(@ruby_gem_name)
    @gems_needing_cleanup = Array(@gems_needing_cleanup) << @ruby_gem_name unless @gem_latest_version_installed
    save_gem_filelist(@ruby_gem_name, @gem_filelist_path)
    add_gem_binary_compression(name) if File.file?(@gem_filelist_path) && no_compile_needed? && system("grep '.so$' #{@gem_filelist_path}", exception: false)
    @ruby_install_extras&.call
    @install_gem = false
    @just_built_gem = false
  end
end
