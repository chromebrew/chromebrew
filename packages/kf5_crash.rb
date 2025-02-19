require 'buildsystems/cmake'

class Kf5_crash < CMake
  description 'KCrash provides support for intercepting and handling application crashes.'
  homepage 'https://invent.kde.org/frameworks/kcrash'
  version '5.116.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/frameworks/kcrash.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3f7dcdc5076b4554bf8ef873b9dd65e980e16deaf6d49ca96be5d9fefacc62f',
     armv7l: 'a3f7dcdc5076b4554bf8ef873b9dd65e980e16deaf6d49ca96be5d9fefacc62f',
     x86_64: 'f4506e38256e4bfa5143b7420934063e97b1d30a997dac41748511b38d07b7f9'
  })

  depends_on 'extra_cmake_modules'
  depends_on 'kf5_coreaddons'
  depends_on 'qt5_base'
  depends_on 'qt5_x11extras'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libx11' # R

  cmake_options "-DECM_MKSPECS_INSTALL_DIR=#{CREW_PREFIX}/share/qt5/mkspecs/modules"
end
