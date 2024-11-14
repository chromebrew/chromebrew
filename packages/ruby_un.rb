require 'buildsystems/ruby'

class Ruby_un < RUBY
  description 'Utilities to replace common unix commands.'
  homepage 'https://github.com/ruby/un'
  version "0.3.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_power_assert' # R

  conflicts_ok
  no_compile_needed
end
