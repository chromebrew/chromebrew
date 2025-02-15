require 'buildsystems/cmake'

class Kf5_widgetsaddons < CMake
  description 'Add-on widgets and classes for applications that use the Qt Widgets module.'
  homepage 'https://invent.kde.org/frameworks/kwidgetsaddons'
  version '5.116.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/frameworks/kwidgetsaddons.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     x86_64: 'e3ea2dd36694fd82f5b2b3e9d6fb0321fed11db795b9b4d8f356fdf26e79ef7b'
  })

  depends_on 'extra_cmake_modules'
  depends_on 'qt5_base'
  depends_on 'qt5_tools'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options "-DECM_MKSPECS_INSTALL_DIR=#{CREW_PREFIX}/share/qt5/mkspecs/modules"
end
