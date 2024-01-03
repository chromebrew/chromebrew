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
    @gem_ver = version.split('-', 2).first
    @ruby_ver = version.split('-', 3).last
    system "yes | gem uninstall -a #{@gem_name}", exception: false
    system "gem install -i #{CREW_DEST_LIB_PREFIX}/ruby/gems/#{@ruby_ver}.0 -n #{CREW_DEST_PREFIX}/bin -N -v #{@gem_ver} #{@gem_name}", exception: false
    eval @ruby_install_extras if @ruby_install_extras
  end
end
