# Adapted from Arch Linux libnghttp3 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libnghttp3/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libnghttp3 < CMake
  description 'HTTP/3 library written in C'
  homepage 'https://github.com/ngtcp2/nghttp3'
  version '1.13.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/nghttp3.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cc891ee6bf72cdb94a9ed9d821b5a3dc2a36126255d7875c308a8deeb9ef051e',
     armv7l: 'cc891ee6bf72cdb94a9ed9d821b5a3dc2a36126255d7875c308a8deeb9ef051e',
       i686: '255089c36df8f30599218a79d2cecd176ad1a760d8c6e0a221868b0071317b30',
     x86_64: '98db5cefcd931ad67271e9a266a61d9fede3327b2033d2d2016e61419cd04c22'
  })

  depends_on 'glibc' # R

  cmake_options '-DENABLE_LIB_ONLY=ON'
end
