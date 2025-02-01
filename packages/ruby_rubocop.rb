# Adapted from Arch Linux ruby-rubocop PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ruby-rubocop

require 'buildsystems/ruby'

class Ruby_rubocop < RUBY
  description 'A Ruby static code analyzer and formatter'
  homepage 'https://rubocop.org'
  version "1.71.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'libyaml'
  depends_on 'xdg_base'

  conflicts_ok
  no_fhs
  no_compile_needed
end
