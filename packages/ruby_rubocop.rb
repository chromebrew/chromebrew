# Adapted from Arch Linux ruby-rubocop PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ruby-rubocop

require 'package'

class Ruby_rubocop < Package
  description 'A Ruby static code analyzer and formatter'
  homepage 'https://rubocop.org'
  version '1.41.1-ruby-3.2'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_rubocop/1.41.1-ruby-3.2_armv7l/ruby_rubocop-1.41.1-ruby-3.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_rubocop/1.41.1-ruby-3.2_armv7l/ruby_rubocop-1.41.1-ruby-3.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_rubocop/1.41.1-ruby-3.2_i686/ruby_rubocop-1.41.1-ruby-3.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_rubocop/1.41.1-ruby-3.2_x86_64/ruby_rubocop-1.41.1-ruby-3.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5091d0c031c4e99a96c6276771f0f004a9b662b29d5a61c70a079203cf473bed',
     armv7l: '5091d0c031c4e99a96c6276771f0f004a9b662b29d5a61c70a079203cf473bed',
       i686: '08c568915137cbad80800158e5470721b55123260bde2fc886d358adaddb9cb2',
     x86_64: '21b15de2bb144c053695fd00878d89e1fb30b5cfca8b51717f0a8615e519eb7d'
  })

  depends_on 'libyaml'
  depends_on 'ruby'
  depends_on 'xdg_base'

  no_fhs

  @xdg_config_home = ENV.fetch('XDG_CONFIG_HOME', nil)
  @xdg_config_home = "#{CREW_PREFIX}/.config" if @xdg_config_home.to_s.empty?

  def self.build; end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/rubocop"
    downloader 'https://github.com/chromebrew/chromebrew/raw/master/.rubocop.yml', 'SKIP',
               "#{CREW_DEST_PREFIX}/.config/rubocop/config.yml"
  end

  def self.postinstall
    @gem_name = name.sub('ruby_', '')
    system "gem install -N #{@gem_name}", exception: false

    puts "Installing Chromebrew rubocop config file at #{@xdg_config_home}/rubocop/config.yml".lightblue
    puts 'This can be overridden by a ~/.rubocop.yml'.lightblue
    # FileUtils.mkdir_p "#{@xdg_config_home}/rubocop"
    # downloader 'https://github.com/chromebrew/chromebrew/raw/master/.rubocop.yml', 'SKIP',
    #            "#{@xdg_config_home}/rubocop/config.yml"
    # Prevent breakage on ruby upgrades by not invoking ruby extensions during postinstall.
    system "curl -Ls https://github.com/chromebrew/chromebrew/raw/master/.rubocop.yml -o #{@xdg_config_home}/rubocop/config.yml"
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

    FileUtils.rm_f "#{@xdg_config_home}/rubocop/config.yml"
  end
end
