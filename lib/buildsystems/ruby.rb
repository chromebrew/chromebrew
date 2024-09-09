require 'package'

class RUBY < Package
  property :ruby_install_extras

  depends_on 'ruby'

  no_compile_needed

  def self.install
    # This assumes the package class name starts with 'Ruby_' and
    # version is in the form '(gem version)-ruby-(ruby version)'.
    # For example, name 'Ruby_awesome' and version '1.0.0-ruby-3.3'.
    @gem_name = name.sub('ruby_', '').sub('_', '-')
    # We only report if @gem_ver is different than the current version reported by gem.
    @gem_ver = version.split('-', 2).first.to_s
    @ruby_ver = version.split('-', 3).last.to_s
    if Kernel.system "gem list -i \"^#{@gem_name}\$\"", %i[out err] => File::NULL
      system "gem update -N #{@gem_name} --conservative"
    else
      system "gem install -N #{@gem_name} --conservative"
    end
    gem_filelist_path = File.join(CREW_META_PATH, "#{name}.filelist")
    system "gem contents #{@gem_name} > #{gem_filelist_path}"
    @ruby_install_extras&.call

    @remote_gem_ver = Gem.latest_spec_for(@gem_name).version.to_s
    return if @remote_gem_ver == @gem_ver

    puts "Note that #{name}.rb suggests that #{@gem_name} version is #{@gem_ver}.\nHowever, gem reports that the installed version is #{@remote_gem_ver}.".orange if Gem::Version.new(@remote_gem_ver.to_s) >= Gem::Version.new(@gem_ver)
  end
end
