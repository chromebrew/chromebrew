# Adapted from Arch Linux libnghttp3 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libnghttp3/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libnghttp3 < CMake
  description 'HTTP/3 library written in C'
  homepage 'https://github.com/ngtcp2/nghttp3'
  version '1.15.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/nghttp3.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a232d4257fd6df6f0365d25d039ad730b637caa31e3804b2188a326c1e10605a',
     armv7l: 'a232d4257fd6df6f0365d25d039ad730b637caa31e3804b2188a326c1e10605a',
       i686: '8eb1f574c24d70c855015ac4258c86206dfeb6990703916c34eb1cc9ef86964e',
     x86_64: '61ca10a660aec6644e1c93ae4c116e03b4812adaa9363e1d4acf8c48401e090d'
  })

  depends_on 'glibc' # R

  cmake_options '-DENABLE_LIB_ONLY=ON'
end
