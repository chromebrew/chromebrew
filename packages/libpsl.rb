require 'buildsystems/meson'

class Libpsl < Meson
  description 'C library for the Public Suffix List'
  homepage 'https://github.com/rockdaboot/libpsl'
  @_ver = '0.21.5'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rockdaboot/libpsl.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56fd7e35ce2706b2b4cf60a74b106ea0b923d14db34ad24e478f72bc070e9160',
     armv7l: '56fd7e35ce2706b2b4cf60a74b106ea0b923d14db34ad24e478f72bc070e9160',
       i686: '7bdb977732ba2994d809ca9eff9623f5d81c6642e03f7870887de5bc8cea1f38',
     x86_64: '56c4274e773e48dccb6c6a0fa5f81f35b90794c63b121b252547daa1c473c797'
  })

  depends_on 'glibc' # R
  depends_on 'libidn2' # R
  depends_on 'libunistring' # R
end
