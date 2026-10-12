require 'buildsystems/autotools'

class Libxcrypt < Autotools
  description 'Modern library for one-way hashing of passwords'
  homepage 'https://github.com/besser82/libxcrypt/'
  version '4.5.2'
  license 'LGPL-2.1+, public-domain, BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/besser82/libxcrypt.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b48a42c6c7ae9844eeb09dfe56e9a7c18898921a489c8d96bd4aa0db4253cf2',
     armv7l: '3b48a42c6c7ae9844eeb09dfe56e9a7c18898921a489c8d96bd4aa0db4253cf2',
       i686: '88a9146e9b8088d2516352893284957a594e1aa97411129272e4724ac5755b1c',
     x86_64: '98228feaf1aa39429a7d688afd0e6f6a605564aefc6d432b9e67e1ace33cf4e2'
  })

  binary_sha256({
    aarch64: '3b48a42c6c7ae9844eeb09dfe56e9a7c18898921a489c8d96bd4aa0db4253cf2',
     armv7l: '3b48a42c6c7ae9844eeb09dfe56e9a7c18898921a489c8d96bd4aa0db4253cf2',
       i686: '88a9146e9b8088d2516352893284957a594e1aa97411129272e4724ac5755b1c',
     x86_64: '98228feaf1aa39429a7d688afd0e6f6a605564aefc6d432b9e67e1ace33cf4e2'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm_dev' => :build

  conflicts_ok

  # ENV['CREW_LINKER'] = 'lld'
  # run_tests
end
