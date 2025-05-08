require 'buildsystems/ruby'

class Ruby_stringio < RUBY
  description 'Pseudo `io` class from/to `string`.'
  homepage 'https://github.com/ruby/stringio'
  version "3.1.7-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'c1ac331f0e70c6d6304570e5f09f6bb45f4c2eea62f6cbca40bde9944b840b68',
     armv7l: 'c1ac331f0e70c6d6304570e5f09f6bb45f4c2eea62f6cbca40bde9944b840b68',
       i686: '04cefb5b21f03a0e60a7ef92f07ca694be4c54fcb288985a85794c6263ea607e',
     x86_64: '775c86d8c451f9c4109d5dadc1f3e673c6c409249bc4fd3bbfae37969ace5358'
  })

  conflicts_ok
  gem_compile_needed
end
