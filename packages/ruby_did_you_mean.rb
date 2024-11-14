require 'buildsystems/ruby'

class Ruby_did_you_mean < RUBY
  description 'The gem that has been saving people from typos since 2014.'
  homepage 'https://github.com/ruby/did_you_mean'
  version "1.6.3-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
