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
    # We ignore @gem_ver and just install the current version of the gem.
    @gem_ver = version.split('-', 2).first
    @ruby_ver = version.split('-', 3).last
    if Kernel.system "gem list -i \"^#{@gem_name}\$\""
      puts "Uninstalling #{@gem_name} before updating. It's ok if this fails.".orange
      system "yes | gem uninstall -a #{@gem_name}", exception: false
    end
    system "gem install -i #{CREW_DEST_LIB_PREFIX}/ruby/gems/#{@ruby_ver}.0 -n #{CREW_DEST_PREFIX}/bin -N #{@gem_name}", exception: false
    @ruby_install_extras&.call
  end
end
