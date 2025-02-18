require 'buildsystems/cmake'

class Kf5_itemmodels < CMake
  description 'Set of item models extending the Qt model-view framework.'
  homepage 'https://invent.kde.org/frameworks/kitemmodels'
  version '5.116.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/frameworks/kitemmodels.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '238cba8582e7114c3c9c124c76d94a94ec655c03597499df2db5b5384c33ca16',
     armv7l: '238cba8582e7114c3c9c124c76d94a94ec655c03597499df2db5b5384c33ca16',
     x86_64: '78d3054234e32d93009b4227f2de1fcd737169cc374dfed1bb8da707e45b5d32'
  })

  depends_on 'extra_cmake_modules'
  depends_on 'qt5_base'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options "-DECM_MKSPECS_INSTALL_DIR=#{CREW_PREFIX}/share/qt5/mkspecs/modules"
end
