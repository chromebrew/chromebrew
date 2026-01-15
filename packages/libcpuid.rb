require 'buildsystems/cmake'

class Libcpuid < CMake
  description 'libcpuid is a small C library for x86 CPU detection and feature extraction.'
  homepage 'https://libcpuid.sourceforge.net/'
  version '0.8.1-1'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/anrieff/libcpuid.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e34d5d3fd5c3211a0d518177cc76163509d526756c58b1207c0c124eb83472f0',
     armv7l: 'e34d5d3fd5c3211a0d518177cc76163509d526756c58b1207c0c124eb83472f0',
       i686: 'b0e10308fb49340c0cac67212f8ddc1177f63694dd5e245e7fe2caf3d05b6436',
     x86_64: 'c2612147763ea31cd27744cf1a89b39d7520bc3c5273e9fe88377b340d79d9ce'
  })

  depends_on 'glibc' # R

  run_tests

  def self.patch
    patches = [
      # Fix libdir
      ['https://github.com/anrieff/libcpuid/pull/221.diff',
       '2a8cdd016bf9f5996e544c5e58b364f59d5fcfb426568bd6e1369a7c428c83a6']
    ]
    ConvenienceFunctions.patch(patches)
  end
end
