require 'buildsystems/ruby'

class Ruby_zlib < RUBY
  description 'Ruby interface for the zlib compression/decompression library.'
  homepage 'https://github.com/ruby/zlib'
  version "3.2.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'cdf422c9dbe8e22c9c64a769306e90d6d0ea2c831f32303e09512148daae4b21',
     armv7l: 'cdf422c9dbe8e22c9c64a769306e90d6d0ea2c831f32303e09512148daae4b21',
       i686: '2782c4957fe1d1aace0d203b0e5f50d9b91be347ca315a0f9d499fac7b57de54',
     x86_64: '3772fea8632656c9c206902465d3d97abd7269c39ede355d5e5706088d0e82f8'
  })

  conflicts_ok
  gem_compile_needed
end
