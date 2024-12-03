require 'buildsystems/ruby'

class Ruby_stringio < RUBY
  description 'Pseudo `io` class from/to `string`.'
  homepage 'https://github.com/ruby/stringio'
  version "3.1.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
     x86_64: '3f0acdab152899c3b4bd9067513eaaac7b688606a4f08524b8b52b3c360d46f9'
  })

  conflicts_ok
  gem_compile_needed
end
