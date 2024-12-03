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
    aarch64: '1ba3f6cd5a6ce7da06ba2764fa543c43c366b9c8110f73966ee98b143ff1b5b3',
     armv7l: '1ba3f6cd5a6ce7da06ba2764fa543c43c366b9c8110f73966ee98b143ff1b5b3',
       i686: '91d5249bd0f1c55f6bb8dbb448e3e5aed00a7332d901b1336912a8e51730297f',
     x86_64: '3f0acdab152899c3b4bd9067513eaaac7b688606a4f08524b8b52b3c360d46f9'
  })

  conflicts_ok
  gem_compile_needed
end
