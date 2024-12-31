require 'buildsystems/ruby'

class Ruby_zlib < RUBY
  description 'Ruby interface for the zlib compression/decompression library.'
  homepage 'https://github.com/ruby/zlib'
  version "3.2.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'eace3994d49283f656b4aacca6637d6210cc67d25ac5cc010b3185c503ccd7fe',
     armv7l: 'eace3994d49283f656b4aacca6637d6210cc67d25ac5cc010b3185c503ccd7fe',
       i686: 'd99c12eaaa2e7e9dbc0e55446b5fe4d046680c5b1fa65ef2710d7b71593df3f6',
     x86_64: 'fb822ab8a5526bc2f5f5b7869598f2f2e1ec1b2b82522ba6f42b24a6058eef6a'
  })

  conflicts_ok
  gem_compile_needed
end
