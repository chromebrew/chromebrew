require 'buildsystems/ruby'

class Ruby_stringio < RUBY
  description 'Pseudo `io` class from/to `string`.'
  homepage 'https://github.com/ruby/stringio'
  version "3.1.6-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'e13a0c99156c4063931f67d61225ae7144a1e8cd7f6a137f2512035600e0a163',
     armv7l: 'e13a0c99156c4063931f67d61225ae7144a1e8cd7f6a137f2512035600e0a163',
       i686: '91ac82ad1018a6802bc93b2f92aadfd36010d4fe885236b5859516df289ffa2f',
     x86_64: '5893f4cc93c911df0b50c1136a167482a64fc3d83d483ff0a79de6ff045441e2'
  })

  conflicts_ok
  gem_compile_needed
end
