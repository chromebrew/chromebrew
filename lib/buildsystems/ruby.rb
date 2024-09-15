require_relative '../const'
require_relative '../package'

class RUBY < Package
  property :ruby_install_extras

  depends_on 'ruby'
  depends_on 'ruby_gem_compiler'

  no_compile_needed

  def self.install
    puts "prerelease is #{prerelease}"
    # puts super(singleton_methods)
    # This assumes the package class name starts with 'Ruby_' and
    # version is in the form '(gem version)-ruby-(ruby version)'.
    # For example, name 'Ruby_awesome' and version '1.0.0-ruby-3.3'.
    @gem_name = name.sub('ruby_', '').sub('_', '-')
    # We only report if @gem_ver is different than the current version reported by gem.
    @gem_ver = version.split('-', 2).first.to_s
    @ruby_ver = version.split('-', 3).last.to_s
    # Need to check if a gem has extensions. If it does, we need
    # buildessential.
    system "gem fetch #{@gem_name} --platform=ruby --version=#{@gem_ver}"
    system "gem unpack #{@gem_name}-#{@gem_ver}.gem"
    gem_extensions = system "grep -q spec.extensions  #{@gem_name}-#{@gem_ver}/#{@gem_name}.gemspec"
    if gem_extensions
      gem_arch = case ARCH
                 when 'x86_64'
                   'x86_64-linux'
                 when 'i686'
                   'x86-linux'
                 when 'aarch64', 'armv7l'
                   'armv8l-linux-eabihf'
                 end
      gem_file = "#{@gem_name}-#{@gem_ver}-#{gem_arch}.gem"
      gem_url = "#{CREW_GITLAB_PKG_REPO}/generic/#{name}/#{version}_#{ARCH}/#{gem_file}"
      if `curl -sI #{gem_url}`.lines.first.split[1] == '200'
        downloader gem_url, 'SKIP'
      else
        abort 'Buildessential needs to be installed for this gem to be built' unless system('which gcc', %i[out err] => File::NULL)
        system "gem compile --strip --prune #{@gem_name}-#{@gem_ver}.gem"
      end
      system "gem install --local #{@gem_name}-#{@gem_ver}-#{gem_arch}.gem"
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
