require 'buildsystems/ruby'

class Ruby_rss < RUBY
  description "Family of libraries that support various formats of XML 'feeds'."
  homepage 'https://github.com/ruby/rss'
  version "0.3.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'


  depends_on 'ruby_rexml' # R

  conflicts_ok
  no_compile_needed
end
