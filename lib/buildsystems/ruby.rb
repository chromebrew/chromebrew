require 'active_support/core_ext/object/blank'
require 'package'
require_relative '../package_helpers'

class RUBY < Package
  property :ruby_install_extras

  depends_on 'ruby'

  def self.preinstall
    # This assumes the package class name starts with 'Ruby_' and
    # version is in the form '(gem version)-ruby-(ruby version)'.
    # For example, name 'Ruby_awesome' and version '1.0.0-ruby-3.3'.
    # puts "@pkg.name is #{@pkg.name}"
    # puts name
    @extract_dir = "#{name}.#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.dir"
    @gem_name = name.sub('ruby_', '').sub('_', '-')
    @gem_ver = version.split('-', 2).first.to_s
    @ruby_ver = version.split('-', 3).last.to_s
    puts "no_compile_needed?: #{no_compile_needed?}, compile_needed?: #{compile_needed?}"
    unless no_compile_needed? || compile_needed?
      puts "Checking to see if gem compile for #{@gem_name} is needed..."
      FileUtils.mkdir_p File.join(CREW_BREW_DIR, @extract_dir)
      Dir.chdir(File.join(CREW_BREW_DIR, @extract_dir)) do
        # Need to check if the gem has extensions. If it does, we need
        # a compiler or a compuled version.
        system "gem fetch #{@gem_name} --platform=ruby --version=#{@gem_ver}"
        system "gem unpack #{@gem_name}-#{@gem_ver}.gem"
        @gem_compile_needed = system "grep -q -r spec.extensions  #{@gem_name}-#{@gem_ver}/*.gemspec", %i[out err] => File::NULL
      end
    end
  end

  def self.install
    puts "no_compile_needed?: #{no_compile_needed?}, @gem_compile.needed.blank?: #{@gem_compile_needed.blank?}, compile_needed?: #{compile_needed?}"
    if !no_compile_needed? || !@gem_compile_needed.blank? || compile_needed?
      gem_arch = case ARCH
                 when 'x86_64'
                   'x86_64-linux'
                 when 'i686'
                   'x86-linux'
                 when 'aarch64', 'armv7l'
                   'armv8l-linux-eabihf'
                 end
      binary_compression 'gem'
      gem_file = "#{@gem_name}-#{@gem_ver}-#{gem_arch}.gem"
      gem_url = "#{CREW_GITLAB_PKG_REPO}/generic/#{name}/#{version}_#{ARCH}/#{gem_file}"
      FileUtils.mkdir_p File.join(CREW_BREW_DIR, @extract_dir)
      Dir.chdir(File.join(CREW_BREW_DIR, @extract_dir)) do
        if `curl -sI #{gem_url}`.lines.first.split[1] == '200'
          sha256sum = PackageUtils.get_sha256(@pkg, build_from_source: false)
          downloader gem_url, sha256sum
        else
          puts "Download of binary gem for #{@gem_name} from the Chromebrew repo at #{gem_url} failed...".orange
          abort 'Buildessential will need to be installed for this gem to be built.'.lightred unless system('which gcc', %i[out err] => File::NULL)
          system "gem fetch #{@gem_name} --platform=ruby --version=#{@gem_ver}"
          system "gem unpack #{@gem_name}-#{@gem_ver}.gem"
          system "gem compile --strip --prune #{@gem_name}-#{@gem_ver}.gem"
        end
        system "gem install -N --local #{@gem_name}-#{@gem_ver}-#{gem_arch}.gem --conservative"
      end
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
