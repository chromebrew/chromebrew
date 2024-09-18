require 'active_support/core_ext/object/blank'
require 'package'
require_relative '../package_helpers'

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
  @gem_name = passed_name.sub('ruby_', '').sub('_', '-')
  @gem_ver = passed_version.split('-').first.to_s
  @pkg_ruby_ver = passed_version.split('ruby-').last.to_s
end

class RUBY < Package
  property :gem_name, :gem_ver, :pkg_ruby_ver, :ruby_install_extras

  depends_on 'ruby'

  def self.preflight
    set_vars(name, version)
    # crewlog "@gem_name: #{@gem_name}, @gem_ver: #{@gem_ver}, @pkg_ruby_ver: #{@pkg_ruby_ver}"
  end

  def self.preinstall
    # @extract_dir = "#{name}.#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.dir"
    @gem_binary_build_needed = check_gem_binary_build_needed(@gem_name, @gem_version) unless no_compile_needed? || gem_compile_needed?
  end

  def self.build
    return if no_compile_needed?

    Kernel.system "gem fetch #{@gem_name} --platform=ruby --version=#{@gem_ver}"
    Kernel.system "gem unpack #{@gem_name}-#{@gem_ver}.gem"
    Kernel.system "gem compile --strip --prune #{@gem_name}-#{@gem_ver}.gem"
  end

  def self.install
    crewlog "no_compile_needed?: #{no_compile_needed?} @gem_binary_build_needed.blank?: #{@gem_binary_build_needed.blank?}, gem_compile_needed?: #{gem_compile_needed?}"
    if !no_compile_needed? || !@gem_binary_build_needed.blank? || gem_compile_needed?
      FileUtils.cp "#{@gem_name}-#{@gem_ver}-#{GEM_ARCH}.gem", CREW_DEST_DIR if File.file?("#{@gem_name}-#{@gem_ver}-#{GEM_ARCH}.gem")
      system "gem install -N --local #{CREW_DEST_DIR}/#{@gem_name}-#{@gem_ver}-#{GEM_ARCH}.gem --conservative"
    elsif Kernel.system "gem list -i \"^#{@gem_name}\$\"", %i[out err] => File::NULL
      system "gem update -N #{@gem_name} --conservative"
    else
      system "gem install -N #{@gem_name} --conservative"
    end
    system "gem cleanup #{@gem_name}"
    gem_filelist_path = File.join(CREW_META_PATH, "#{name}.filelist")
    system "gem contents #{@gem_name} > #{gem_filelist_path}"
    @ruby_install_extras&.call

    @remote_gem_ver = Gem.latest_spec_for(@gem_name).version.to_s
    return if @remote_gem_ver == @gem_ver

    puts "Note that #{name}.rb suggests that #{@gem_name} version is #{@gem_ver}.\nHowever, gem reports that the installed version is #{@remote_gem_ver}.".orange if Gem::Version.new(@remote_gem_ver.to_s) >= Gem::Version.new(@gem_ver)
  end
end
