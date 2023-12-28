# Adapted from Arch Linux ruby-rubocop PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ruby-rubocop

require 'package'

class Ruby_rubocop < Package
  description 'A Ruby static code analyzer and formatter'
  homepage 'https://rubocop.org'
  version '1.57.2-ruby-3.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/chromebrew/raw/master/.rubocop.yml'
  source_sha256 '3942911bbee4c316617fa78825160726a398737db9a6085c743c9477acd55222'

  depends_on 'libyaml'
  depends_on 'ruby'
  depends_on 'xdg_base'

  no_fhs
  no_compile_needed

  def self.install
    FileUtils.install '.rubocop.yml', "#{CREW_DEST_PREFIX}/.config/rubocop/config.yml", mode: 0o644
  end

  def self.postinstall
    @gem_name = name.sub('ruby_', '')
    system "gem install -N #{@gem_name}", exception: false

    puts "Chromebrew rubocop config file was installed at #{CREW_PREFIX}/.config/rubocop/config.yml".lightblue
    puts 'This can be overridden by a ~/.rubocop.yml'.lightblue
  end

  def self.remove
    @gem_name = name.sub('ruby_', '')
    @gems_deps = `gem dependency ^#{@gem_name}\$ | awk '{print \$1}'`.chomp
    # Delete the first line and convert to an array.
    @gems = @gems_deps.split("\n").drop(1).append(@gem_name)
    # bundler never gets uninstalled, though gem dependency lists it for
    # every package, so delete it from the list.
    @gems.delete('bundler')
    @gems.each do |gem|
      system "gem uninstall -Dx --force --abort-on-dependent #{gem}", exception: false
    end
  end
end
