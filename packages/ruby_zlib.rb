require 'buildsystems/ruby'

class Ruby_zlib < RUBY
  description 'Ruby interface for the zlib compression/decompression library.'
  homepage 'https://github.com/ruby/zlib'
  version "3.3.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '5e05e90ef1453e4dd044b54d793a54679f6d6ef48e069bf5055016851492c7bf',
     armv7l: '5e05e90ef1453e4dd044b54d793a54679f6d6ef48e069bf5055016851492c7bf',
       i686: '95c1b3b309257de7a35650e6be8a30c8bc590e3ac9da6b58af26555bdd41ca0d',
     x86_64: 'eb41c307e57e69e8113b846d511f4b6230d02b6b995cd6712c20be2e455a7d64'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library
  depends_on 'zlib' => :library

  conflicts_ok
  gem_compile_needed
end
