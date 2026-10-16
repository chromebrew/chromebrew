require 'buildsystems/cmake'

class Libdeflate < CMake
  description 'Heavily optimized library for DEFLATE compression and decompression'
  homepage 'https://github.com/ebiggers/libdeflate/'
  version '1.26'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ebiggers/libdeflate.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09f4ba09ee4140b65bffede9d32abede0688a71b2b5eb818fd95579036ed0d7d',
     armv7l: '09f4ba09ee4140b65bffede9d32abede0688a71b2b5eb818fd95579036ed0d7d',
       i686: '1dc88235b7c2923bb463d9345ead40114c67ae253fb17a504d5f0012e13980b2',
     x86_64: 'acc4b438a35a797fe58c128755b3b10e0f2e34c512098eb18b9e9019003b2dd4'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
