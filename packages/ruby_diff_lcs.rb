require 'buildsystems/ruby'

class Ruby_diff_lcs < RUBY
  description 'Diff::LCS computes the difference between two Enumerable sequences using the McIlroy-Hunt longest common subsequence (LCS) algorithm.'
  homepage 'https://github.com/halostatue/diff-lcs'
  version "1.6.2-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
