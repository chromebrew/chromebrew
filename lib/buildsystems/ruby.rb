require 'color'
require 'package'

def require_gem(gem_name_and_require = nil, require_override = nil)
  # Allow only loading gems when needed.
  return if gem_name_and_require.nil?

  gem_name = gem_name_and_require.split('/')[0]
  begin
    gem gem_name
  rescue LoadError
    puts " -> install #{gem_name} gem".orange
    Gem.install(gem_name)
    gem gem_name
  end
  requires = if require_override.nil?
               gem_name_and_require.split('/')[1].nil? ? gem_name_and_require.split('/')[0] : gem_name_and_require
             else
               require_override
             end
  require requires
end
require_gem('activesupport', 'active_support/core_ext/object/blank')

def check_gem_binary_build_needed(gem_name = nil, gem_ver = nil)
  puts "Checking to see if gem compile for #{gem_name} is needed..."
  @extract_dir = "#{name}.#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.dir"
  FileUtils.mkdir_p File.join(CREW_BREW_DIR, @extract_dir)
  Dir.chdir(File.join(CREW_BREW_DIR, @extract_dir)) do
    # Need to check if the gem has extensions. If it does, we need
    # either a compiler or a pre-compiled binary gem.
    system "gem fetch #{gem_name} --platform=ruby --version=#{gem_ver}"
    system "gem unpack #{gem_name}-#{gem_ver}.gem"
    return system "grep -q -r spec.extensions  #{gem_name}-#{gem_ver}/*.gemspec", %i[out err] => File::NULL
  end
end

def set_vars(passed_name = nil, passed_version = nil)
  # crewlog "Setting gem variables... name: #{passed_name}, version: #{passed_version}"
  # This assumes the package class name starts with 'Ruby_' and
  # version is in the form '(gem version)-ruby-(ruby version)'.
  # For example, name 'Ruby_awesome' and version '1.0.0-ruby-3.3'.
  gem_name_test = passed_name.gsub(/^ruby_/, '')
  @remote_gem_ver = Gem.latest_version_for(gem_name_test).to_s
  @remote_gem_ver = Gem.latest_version_for(gem_name_test.gsub!('_', '-')).to_s if @remote_gem_ver.empty?
  @gem_name = gem_name_test
  @gem_ver = passed_version.split('-').first.to_s
  puts "Note that #{name}.rb suggests that latest #{@gem_name} version is #{@gem_ver}.\nHowever, gem reports that the latest version is #{@remote_gem_ver}.".orange if Gem::Version.new(@remote_gem_ver.to_s) > Gem::Version.new(@gem_ver)
end

class RUBY < Package
  property :gem_name, :gem_ver, :ruby_install_extras

  depends_on 'ruby'

  def self.preflight
    @install_gem = true
    set_vars(name, version)
    @gem_filelist_path = File.join(CREW_META_PATH, "#{name}.filelist")
    @gem_installed = Kernel.system "gem list -i \"^#{@gem_name}\$\" -v #{@gem_ver}", %i[out err] => File::NULL
    gem_installed_anyver = Kernel.system "gem list -i \"^#{@gem_name}\$\"", %i[out err] => File::NULL
    @gem_outdated = !@gem_installed && gem_installed_anyver
    crewlog "preflight: @gem_name: #{@gem_name}, @gem_ver: #{@gem_ver}, @gem_outdated: #{@gem_outdated}, @gem_installed: #{@gem_installed} && @remote_gem_ver.to_s: #{Gem::Version.new(@remote_gem_ver.to_s)} == Gem::Version.new(@gem_ver): #{Gem::Version.new(@gem_ver)} && File.file?(@gem_filelist_path): #{File.file?(@gem_filelist_path)}"
    if @gem_installed && Gem::Version.new(@remote_gem_ver.to_s) == Gem::Version.new(@gem_ver)
      system "gem contents #{@gem_name} > #{@gem_filelist_path}" unless File.file?(@gem_filelist_path)
      @install_gem = false
    end
  end

  def self.preinstall
    @gem_binary_build_needed = check_gem_binary_build_needed(@gem_name, @gem_version) unless no_compile_needed? || gem_compile_needed?
  end

  def self.build
    return unless !no_compile_needed? || @gem_binary_build_needed

    Kernel.system "gem fetch #{@gem_name} --platform=ruby --version=#{@gem_ver}"
    Kernel.system "gem unpack #{@gem_name}-#{@gem_ver}.gem"
    Kernel.system "gem compile --strip --prune #{@gem_name}-#{@gem_ver}.gem"
    FileUtils.cp "#{@gem_name}-#{@gem_ver}-#{GEM_ARCH}.gem", CREW_DEST_DIR if File.file?("#{@gem_name}-#{@gem_ver}-#{GEM_ARCH}.gem") && (!@gem_binary_build_needed.blank? || gem_compile_needed?)
  end

  def self.install
    crewlog "install: @gem_name: #{@gem_name}, @gem_ver: #{@gem_ver}, @gem_outdated: #{@gem_outdated}, @gem_installed: #{@gem_installed} && @remote_gem_ver.to_s: #{Gem::Version.new(@remote_gem_ver.to_s)} == Gem::Version.new(@gem_ver): #{Gem::Version.new(@gem_ver)} && File.file?(@gem_filelist_path): #{File.file?(@gem_filelist_path)}"
    crewlog "no_compile_needed?: #{no_compile_needed?} @gem_binary_build_needed.blank?: #{@gem_binary_build_needed.blank?}, gem_compile_needed?: #{gem_compile_needed?}"
    FileUtils.cp "#{@gem_name}-#{@gem_ver}-#{GEM_ARCH}.gem", CREW_DEST_DIR if File.file?("#{@gem_name}-#{@gem_ver}-#{GEM_ARCH}.gem") && (!@gem_binary_build_needed.blank? || gem_compile_needed?)
    unless @install_gem
      puts "#{@gem_name} #{@gem_ver} is already installed.".lightgreen
      return
    end
    puts "#{@gem_name.capitalize} needs a binary gem built!".orange unless @gem_binary_build_needed.blank?
    if !no_compile_needed? || !@gem_binary_build_needed.blank? || gem_compile_needed?
      system "gem install -N --local #{CREW_DEST_DIR}/#{@gem_name}-#{@gem_ver}-#{GEM_ARCH}.gem --conservative"
    elsif @gem_outdated
      puts "Updating #{@gem_name} gem to #{@gem_ver}...".orange
      system "gem update -N #{@gem_name} --conservative"
    else
      system "gem install -N #{@gem_name} --conservative"
    end
    system "gem cleanup #{@gem_name}"
    system "gem contents #{@gem_name} > #{@gem_filelist_path}"
    @ruby_install_extras&.call
    @install_gem = false
  end
end
