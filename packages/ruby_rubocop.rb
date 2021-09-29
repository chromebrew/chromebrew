# Adapted from Arch Linux ruby-rubocop PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ruby-rubocop

require 'package'

class Ruby_rubocop < Package
  description 'A Ruby static code analyzer and formatter'
  homepage 'https://rubocop.org'
  version '1.22.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'libyaml'
  depends_on 'xdg_base'

  @xdg_config_home = ENV['XDG_CONFIG_HOME']
  @xdg_config_home = "#{CREW_PREFIX}/.config" if @xdg_config_home.to_s.empty?

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    FileUtils.mkdir_p "#{CREW_DEST_DIR}#{@xdg_config_home}/rubocop"
  end

  def self.postinstall
    system 'gem install -N rubocop --conservative'
    puts "Installing Chromebrew rubocop config file at #{@xdg_config_home}/rubocop/config.yml".lightblue
    puts "This can be overridden by a ~/.rubocop.yml".lightblue
    system "curl -Ls https://github.com/chromebrew/chromebrew/raw/master/.rubocop.yml > #{@xdg_config_home}/rubocop/config.yml"
  end

  def self.remove
    system 'gem uninstall -x rubocop'
  end
end
