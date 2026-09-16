require 'buildsystems/cmake'

class Libcpuid < CMake
  description 'libcpuid is a small C library for x86 CPU detection and feature extraction.'
  homepage 'https://libcpuid.sourceforge.net/'
  version '0.8.2'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/anrieff/libcpuid.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '809660da557b18a9c906af53caba1034a911b3407b7dc0cdc6e7678bc2744f72',
     armv7l: '809660da557b18a9c906af53caba1034a911b3407b7dc0cdc6e7678bc2744f72',
       i686: '60188195a5f5e749f533de37da119a52e8cf99b5f1cdd09c485bc98145b9d004',
     x86_64: 'cffc3d719a5514346527c0b3c047e3c69e94007baa5eb1fad9fa463ec9d5f0b8'
  })

  depends_on 'glibc' => :library

  run_tests
end
