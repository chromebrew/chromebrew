require 'buildsystems/ruby'

class Ruby_pstore < RUBY
  description 'Transactional file storage for ruby objects.'
  homepage 'https://github.com/ruby/pstore'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
