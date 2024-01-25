# Adapted from Arch Linux cppdap PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cppdap

require 'buildsystems/cmake'

class Cppdap < CMake
  description 'C++ library for the Debug Adapter Protocol'
  homepage 'https://github.com/google/cppdap'
  version '1.58.0a-6a3cc9a'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/google/cppdap.git'
  git_hashtag '6a3cc9a804e83c40f4202fe6a34c8911d2c7c12b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '486079c36410ea29f539e07546d978937214fdb0594ed4f5aa805a48494653ac',
     armv7l: '486079c36410ea29f539e07546d978937214fdb0594ed4f5aa805a48494653ac',
       i686: 'cebdff78b54b773b55abe9f926cd0363f330cc3419ea23bfd3a5fc2ef348f867',
     x86_64: '6027ccffddf103dfda7af1f664e63a1206f15d55e26491e02ae3b597f4782be7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
