require 'buildsystems/cmake'

class Kf5_completion < CMake
  description 'Powerful completion framework, including completion-enabled lineedit and combobox.'
  homepage 'https://invent.kde.org/frameworks/kcompletion'
  version '5.116.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/frameworks/kcompletion.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     x86_64: '7a5250cd74b291113c011de64fabfd6c5f3f6e023e9d73f5ec710e72b36b5882'
  })

  depends_on 'extra_cmake_modules'
  depends_on 'kf5_config'
  depends_on 'kf5_widgetsaddons'
  depends_on 'qt5_base'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options "-DECM_MKSPECS_INSTALL_DIR=#{CREW_PREFIX}/share/qt5/mkspecs/modules"
end
