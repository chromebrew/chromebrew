# Adapted from Arch Linux ruby-rubocop PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ruby-rubocop

require 'buildsystems/ruby'

class Ruby_rubocop < RUBY
  description 'A Ruby static code analyzer and formatter'
  homepage 'https://rubocop.org'
  version '1.59.0-ruby-3.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/chromebrew/raw/master/.rubocop.yml'
  source_sha256 '3942911bbee4c316617fa78825160726a398737db9a6085c743c9477acd55222'

  depends_on 'libyaml'
  depends_on 'xdg_base'

  conflicts_ok
  no_fhs

  ruby_install_extras <<~EOF
    FileUtils.install '.rubocop.yml', "#{CREW_DEST_PREFIX}/.config/rubocop/config.yml", mode: 0o644
  EOF

  def self.postinstall
    puts "Chromebrew rubocop config file was installed at #{CREW_PREFIX}/.config/rubocop/config.yml".lightblue
    puts 'This can be overridden by a ~/.rubocop.yml'.lightblue
  end
end
