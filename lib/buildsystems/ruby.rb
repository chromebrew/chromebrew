require 'color'
require 'gem_compact_index_client'
require 'package'
require 'package_utils'
require 'require_gem'

require_gem('activesupport', 'active_support/core_ext/object/blank')

def check_gem_binary_build_needed(gem_name = nil, gem_version = nil)
  puts "Checking to see if gem compile for #{gem_name} is needed..."
  @extract_dir = "#{gem_name}.#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.dir"
  FileUtils.mkdir_p File.join(CREW_BREW_DIR, @extract_dir)
  Dir.chdir(File.join(CREW_BREW_DIR, @extract_dir)) do
    # Need to check if the gem has extensions. If it does, we need
    # either a compiler or a pre-compiled binary gem.
    system "gem fetch #{gem_name} --platform=ruby --version=#{gem_version}"
    system "gem unpack #{gem_name}-#{gem_version}.gem"
    system "grep -q -r spec.extensions  #{gem_name}-#{gem_version}/*.gemspec", %i[out err] => File::NULL
    @build_needed = system "grep -q -r spec.extensions  #{gem_name}-#{gem_version}/*.gemspec", %i[out err] => File::NULL
  end
  FileUtils.rm_rf File.join(CREW_BREW_DIR, @extract_dir)
  return @build_needed
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
  gem_test = $gems.grep(/#{"^#{passed_name.gsub(/^ruby_/, '')}\\s.*$"}/).last.blank? ? $gems.grep(/#{"^\(#{passed_name.gsub(/^ruby_/, '').gsub('_', ')*.(')}\\s\).*$"}/).last : $gems.grep(/#{"^#{passed_name.gsub(/^ruby_/, '')}\\s.*$"}/).last
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
  @gem_name = gem_test_name.blank? ? Gem::SpecFetcher.fetcher.suggest_gems_from_name(passed_name.gsub(/^ruby_/, '')).first : gem_test_name
  @remote_gem_version = gem_test_name.blank? ? Gem.latest_version_for(@gem_name).to_s : gem_test_version
  @gem_version = passed_version.split('-').first.to_s
  @gem_package_ver = @gem_version.dup
  # Use latest gem version.
  @gem_version = @remote_gem_version.to_s if Gem::Version.new(@remote_gem_version.to_s) > Gem::Version.new(@gem_version)
end

class RUBY < Package
  property :gem_name, :gem_version, :ruby_install_extras

  depends_on 'ruby'

  def self.preflight
    @install_gem ||= true
    set_vars(name, version)
    puts "Examining #{@gem_name} gem...".orange
    @gem_filelist_path = File.join(CREW_META_PATH, "#{name}.filelist")
    installed_gem_search = [`gem list -l -e #{@gem_name}`.chomp.to_s].grep(/#{@gem_name}/)[0]
    if installed_gem_search
      installed_gem_info = installed_gem_search.delete('()').gsub('default:', '').gsub(',', '').split
      @gem_installed_version = installed_gem_info[1]
      @gem_outdated = (Gem::Version.new(@gem_version) > Gem::Version.new(@gem_installed_version))
      @gem_latest_version_installed = Gem::Version.new(@gem_version) <= Gem::Version.new(@gem_installed_version)
      crewlog "@gem_version: #{@gem_version} @gem_installed_version: #{@gem_installed_version} @gem_outdated: #{@gem_outdated} @gem_latest_version_installed: #{@gem_latest_version_installed}"
    end

    # Create a filelist from the gem if the latest gem version is
    # installed but the filelist doesn't exist.
    Kernel.system "gem contents #{@gem_name}", %i[out] => [@gem_filelist_path, 'w'] if @gem_latest_version_installed && !File.file?(@gem_filelist_path)
    # If the version number gem reports isn't newer than the version
    # number that Chromebrew has recorded, force an install.
    # Otherwise we can skip the install and bail.
    @device = ConvenienceFunctions.load_symbolized_json
    pkg_info = @device[:installed_packages].select { |pkg| pkg[:name] == name } [0]
    return if pkg_info.nil?

    # Handle case of the Chromebrew gem pkg not yet having been
    # installed or having a changed version number despite the gem
    # having been installed.
    @json_gem_pkg_version = pkg_info[:version].gsub!('_', '-').to_s
    @install_gem = false if Gem::Version.new(@gem_version) <= Gem::Version.new(@json_gem_pkg_version)
  end

  def self.preinstall
    @gem_binary_build_needed = check_gem_binary_build_needed(@gem_name, @gem_version) unless no_compile_needed? || gem_compile_needed?
  end

  def self.build
    return unless !no_compile_needed? || @gem_binary_build_needed

    Kernel.system "gem fetch #{@gem_name} --platform=ruby --version=#{@gem_version}"
    Kernel.system "gem unpack #{@gem_name}-#{@gem_version}.gem"
    system 'gem install gem-compiler' unless Kernel.system('gem compile --help 2>/dev/null', %i[out err] => File::NULL)
    Kernel.system "gem compile --strip --prune #{@gem_name}-#{@gem_version}.gem -O #{CREW_DEST_DIR}/"
    @just_built_gem = true
  end

  def self.install
    # @install_gem will always be true during upgrades since we remove
    # the old gem during the upgrade.
    unless @install_gem
      puts "#{@gem_name} #{@gem_installed_version} is properly installed.".lightgreen
      return
    end
    installed_gem_search = [`gem list --no-update-sources -l -e #{@gem_name}`.chomp.to_s].grep(/#{@gem_name}/)[0]
    if installed_gem_search
      installed_gem_info = installed_gem_search.delete('()').gsub('default:', '').gsub(',', '').split
      @gem_installed_version = installed_gem_info[1]
      @gem_outdated = (Gem::Version.new(@gem_version) > Gem::Version.new(@gem_installed_version))
      @gem_latest_version_installed = Gem::Version.new(@gem_version) <= Gem::Version.new(@gem_installed_version)
      crewlog "@gem_version: #{@gem_version} @gem_installed_version: #{@gem_installed_version} @gem_outdated: #{@gem_outdated} @gem_latest_version_installed: #{@gem_latest_version_installed}"
    else
      # If the current gem being installed is not installed this should
      # be false. This will also handle cases of the current installed
      # gem as per 'gem list' being the same version as the version
      # being upgraded to.
      @gem_latest_version_installed = false
    end

    crewlog "no_compile_needed?: #{no_compile_needed?} @gem_binary_build_needed.blank?: #{@gem_binary_build_needed.blank?}, gem_compile_needed?: #{gem_compile_needed?}"
    puts "#{@gem_name.capitalize} needs a binary gem built!".orange unless @gem_binary_build_needed.blank?
    if !no_compile_needed? || !@gem_binary_build_needed.blank? || gem_compile_needed?
      @gem_pkg = Package.load_package(File.join(CREW_PACKAGES_PATH, "#{name}.rb"))
      gem_pkg_sha256sum = PackageUtils.get_sha256(@gem_pkg)
      gem_sha256 = `sha256sum #{CREW_DEST_DIR}/#{@gem_name}-#{@gem_version}-#{GEM_ARCH}.gem`.chomp.split.first
      if File.file?("#{CREW_DEST_DIR}/#{@gem_name}-#{@gem_version}-#{GEM_ARCH}.gem") && (gem_sha256 == gem_pkg_sha256sum || @just_built_gem)
        puts "Installing #{@gem_name} gem #{@gem_version}...".orange
        Kernel.system "gem install --no-update-sources -N --local #{CREW_DEST_DIR}/#{@gem_name}-#{@gem_version}-#{GEM_ARCH}.gem --conservative"
      end
    elsif @gem_outdated || Gem::Version.new(@gem_version) <= Gem::Version.new(@json_gem_pkg_version)
      puts "Updating #{@gem_name} gem: #{@gem_installed_version} 🔜 #{@gem_version} ...".orange
      Kernel.system "gem update --no-update-sources -N #{@gem_name} --conservative"
    elsif !@gem_latest_version_installed
      puts "Installing #{@gem_name} gem #{@gem_version}...".orange
      Kernel.system "gem install --no-update-sources -N #{@gem_name} --conservative"
    end
    @gems_needing_cleanup = Array(@gems_needing_cleanup) << @gem_name unless @gem_latest_version_installed
    Kernel.system "gem contents #{@gem_name}", %i[out] => [@gem_filelist_path, 'w']
    @ruby_install_extras&.call
    @install_gem = false
    @just_built_gem = false
  end
end
