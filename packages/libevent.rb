require 'buildsystems/cmake'

class Libevent < CMake
  description 'The libevent API provides a mechanism to execute a callback function when a specific event occurs on a file descriptor or after a timeout has been reached.'
  homepage 'http://libevent.org/'
  version '2.2-64decd4'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/libevent/libevent.git'
  git_hashtag '64decd48e20f6d20d6f510aa75ab05861fd3d51c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8e80ad3a816756ed0a10d2b036f756dbee87cefc8eada17a2e81184ec79343b',
      armv7l: 'd8e80ad3a816756ed0a10d2b036f756dbee87cefc8eada17a2e81184ec79343b',
        i686: '79aeefd04d639e1a57bd3e0acdb91196ccb5bd326f25d10d8b2b4da5b22cf8cc',
      x86_64: '5fee31e3b068d46c7cddb56c830893ac2bedcac948f0ef2c3f655f6c5fc2b448'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
end
