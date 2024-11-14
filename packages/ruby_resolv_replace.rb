require 'buildsystems/ruby'

class Ruby_resolv_replace < RUBY
  description 'Replace socket dns with resolv.'
  homepage 'https://github.com/ruby/resolv-replace'
  version "0.1.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_resolv' # R

  conflicts_ok
  no_compile_needed
end
