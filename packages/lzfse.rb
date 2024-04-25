# Adapted from Arch Linux lzfse PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=lzfse

require 'buildsystems/cmake'

class Lzfse < CMake
  description 'The LZFSE compression library and command line tool'
  homepage 'https://github.com/lzfse/lzfse'
  version '1.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/lzfse/lzfse.git'
  git_hashtag 'lzfse-1.0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4aca531b2da2f2f6760a4451e8d571557061d312dcdb8f57d32b4a286c3c1cb6',
     armv7l: '4aca531b2da2f2f6760a4451e8d571557061d312dcdb8f57d32b4a286c3c1cb6',
       i686: '5ce5db851f62a5f104a7ca20cc49805281638af5955c8b3541db92c11c307f2f',
     x86_64: '086c30927b7fff625f4435bac807af85f584cfeeb86f64585a0de952c1f1261e'
  })

  depends_on 'glibc' # R
end
