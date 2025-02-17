require 'buildsystems/cmake'

class Kf5_coreaddons < CMake
  description 'Qt addon library with a collection of non-GUI utilities.'
  homepage 'https://invent.kde.org/frameworks/kcoreaddons'
  version '5.116.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/frameworks/kcoreaddons.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ee514eb1c5970d7a6a59a97fcaac6484bf0dafd3748cfe17147a6dc9183cdbb0',
     armv7l: 'ee514eb1c5970d7a6a59a97fcaac6484bf0dafd3748cfe17147a6dc9183cdbb0',
     x86_64: '16dc9ae0d5908c9e59d4d2cbcd897d2f81e467cc0e80e2417fec6fcb983a9933'
  })

  depends_on 'extra_cmake_modules'
  depends_on 'qt5_base'
  depends_on 'qt5_tools'
  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options "-DECM_MKSPECS_INSTALL_DIR=#{CREW_PREFIX}/share/qt5/mkspecs/modules"
end
