require 'buildsystems/cmake'

class Kf5_config < CMake
  description 'Persistent platform-independent application settings.'
  homepage 'https://invent.kde.org/frameworks/kconfig'
  version '5.116.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/frameworks/kconfig.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ff4dbaec968f67466ae6912e9f9f691fd1d6fe5c898d750cfac50908f919802',
     armv7l: '4ff4dbaec968f67466ae6912e9f9f691fd1d6fe5c898d750cfac50908f919802',
     x86_64: 'c7f001a027cfd6b76662f8eea611073d84235d36011ef36b2a9413b0b81e7e6d'
  })

  depends_on 'extra_cmake_modules'
  depends_on 'qt5_base'
  depends_on 'qt5_declarative'
  depends_on 'qt5_tools'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options "-DECM_MKSPECS_INSTALL_DIR=#{CREW_PREFIX}/share/qt5/mkspecs/modules"
end
