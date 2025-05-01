# Adapted from Arch Linux ruby-rubocop PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ruby-rubocop

require 'buildsystems/ruby'

class Ruby_rubocop < RUBY
  description 'A Ruby static code analyzer and formatter'
  homepage 'https://rubocop.org'
  version "1.75.4-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'libyaml' # R
  depends_on 'ruby_json' # R
  depends_on 'ruby_language_server_protocol' # R
  depends_on 'ruby_parallel' # R
  depends_on 'ruby_parser' # R
  depends_on 'ruby_parser' # R
  depends_on 'ruby_rainbow' # R
  depends_on 'ruby_regexp_parser' # R
  depends_on 'ruby_rubocop' # R
  depends_on 'ruby_rubocop_ast' # R
  depends_on 'ruby_rubocop_chromebrew' # R
  depends_on 'ruby_ruby_progressbar' # R
  depends_on 'ruby_unicode_display_width' # R
  depends_on 'xdg_base' # L

  conflicts_ok
  no_fhs
  no_compile_needed
end
