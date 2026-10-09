require 'buildsystems/ruby'

class Ruby_zlib < RUBY
  description 'Ruby interface for the zlib compression/decompression library.'
  homepage 'https://github.com/ruby/zlib'
  version "3.2.4-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '9a11e527139f9d786966af7fcec6f9cdaf89b4f2daa13abe39b9a9b89c7976c4',
     armv7l: '9a11e527139f9d786966af7fcec6f9cdaf89b4f2daa13abe39b9a9b89c7976c4',
       i686: 'e0d74317d8c9bf82fc7c4898d5bda8641319eaa353fca57c52d6f26985601e48',
     x86_64: 'f49d2c6e9ec8e1844c817eadd84342bc37d2799d3c0147ac1d4bfb5ff05b16df'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library
  depends_on 'zlib' => :library

  conflicts_ok
  gem_compile_needed
end
