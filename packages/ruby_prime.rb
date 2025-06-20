require 'buildsystems/ruby'

class Ruby_prime < RUBY
  description 'Prime numbers and factorization library.'
  homepage 'https://github.com/ruby/prime'
  version "0.1.4-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_forwardable' # R
  depends_on 'ruby_singleton' # R

  conflicts_ok
  no_compile_needed
end
