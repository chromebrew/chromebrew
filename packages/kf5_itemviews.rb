require 'buildsystems/cmake'

class Kf5_itemviews < CMake
  description 'Set of item views extending the Qt model-view framework.'
  homepage 'https://invent.kde.org/frameworks/kitemviews'
  version '5.116.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/frameworks/kitemviews.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a5e7ba59e45980ec7f9a59b355eb0275a3676e30a54cf72380511aa859c1d51',
     armv7l: '6a5e7ba59e45980ec7f9a59b355eb0275a3676e30a54cf72380511aa859c1d51',
     x86_64: '684f204cd21bb1089f2ad88fc4a7114fd7bd8c1d98359bd4f18567ba4ccdffe5'
  })

  depends_on 'extra_cmake_modules'
  depends_on 'qt5_base'
  depends_on 'qt5_tools'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options "-DECM_MKSPECS_INSTALL_DIR=#{CREW_PREFIX}/share/qt5/mkspecs/modules"
end
