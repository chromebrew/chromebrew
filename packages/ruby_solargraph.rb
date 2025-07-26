require 'buildsystems/ruby'

class Ruby_solargraph < RUBY
  description 'IDE tools for code completion, inline documentation, and static analysis.'
  homepage 'https://solargraph.org'
  version "0.56.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_backport' # R
  depends_on 'ruby_benchmark' # R
  depends_on 'ruby_bundler' # R
  depends_on 'ruby_diff_lcs' # R
  depends_on 'ruby_jaro_winkler' # R
  depends_on 'ruby_kramdown' # R
  depends_on 'ruby_kramdown_parser_gfm' # R
  depends_on 'ruby_logger' # R
  depends_on 'ruby_observer' # R
  depends_on 'ruby_ostruct' # R
  depends_on 'ruby_parser' # R
  depends_on 'ruby_prism' # R
  depends_on 'ruby_rbs' # R
  depends_on 'ruby_reverse_markdown' # R
  depends_on 'ruby_rubocop' # R
  depends_on 'ruby_thor' # R
  depends_on 'ruby_tilt' # R
  depends_on 'ruby_yard' # R
  depends_on 'ruby_yard_solargraph' # R

  conflicts_ok
  no_compile_needed
end
