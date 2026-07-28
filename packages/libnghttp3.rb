# Adapted from Arch Linux libnghttp3 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libnghttp3/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libnghttp3 < CMake
  description 'HTTP/3 library written in C'
  homepage 'https://github.com/ngtcp2/nghttp3'
  version '1.18.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/nghttp3.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1c0f6ed8ea85066f7cf5e8c6d49daf17b74c9459fdda40515849db235c69e32f',
     armv7l: '1c0f6ed8ea85066f7cf5e8c6d49daf17b74c9459fdda40515849db235c69e32f',
       i686: 'ed799cfd93a5ded2c8cd2022406674148533df10617d44f42837fab8443b1362',
     x86_64: '0fcfbdd01c9698572403805e6d6f4065c64b8005781443f143ae2baaffaa754f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DENABLE_LIB_ONLY=ON'
end
