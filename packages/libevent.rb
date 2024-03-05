require 'buildsystems/cmake'

class Libevent < CMake
  description 'The libevent API provides a mechanism to execute a callback function when a specific event occurs on a file descriptor or after a timeout has been reached.'
  homepage 'http://libevent.org/'
  version '2.2-f2b3ce6'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/libevent/libevent.git'
  git_hashtag 'f2b3ce6b5587efb206bc74298d7a835372ce2caf'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a8f0cb7221c99bcafac9e859b29f8f2e2598fc27a4298d846996100dafc2556',
      armv7l: '6a8f0cb7221c99bcafac9e859b29f8f2e2598fc27a4298d846996100dafc2556',
        i686: '163311e020dc2c2bf9825518e990efbd3373a2a7f8251d625b63bca1e4547baa',
      x86_64: '6885dced405129dd97bf398517d35dbdab2797b9c9f117dcbdc2a78764e67b05'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
end
