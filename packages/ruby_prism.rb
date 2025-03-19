require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "1.4.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'f2c39f15d96f653b034fe37f11d8ab03f87a4885b15a0bd948431634f366b77f',
     armv7l: 'f2c39f15d96f653b034fe37f11d8ab03f87a4885b15a0bd948431634f366b77f',
       i686: '08982eda391aa25421937df5a4c7b98b7a910ec11ef0ecd5733a27dbba6d7fd5',
     x86_64: '73c7ec0d75c63e08250a6231ee5af12395cf6181c497a17fea943747467bc3fb'
  })

  conflicts_ok
  gem_compile_needed
end
