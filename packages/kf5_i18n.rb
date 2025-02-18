require 'buildsystems/cmake'

class Kf5_i18n < CMake
  description 'KI18n provides functionality for internationalizing user interface text in applications, based on the GNU Gettext translation system.'
  homepage 'https://invent.kde.org/frameworks/ki18n'
  version '5.116.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/frameworks/ki18n.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '15d350ab61d1600b031e6243b376478c7c88197202b0b5ead6c386e0bdedcfa0',
     armv7l: '15d350ab61d1600b031e6243b376478c7c88197202b0b5ead6c386e0bdedcfa0',
     x86_64: 'eeefaa742dc51e480aa26cd2771a19ab153a1c36a9556653dfa6ab812a345bbe'
  })

  depends_on 'extra_cmake_modules'
  depends_on 'qt5_base'
  depends_on 'qt5_declarative'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options "-DECM_MKSPECS_INSTALL_DIR=#{CREW_PREFIX}/share/qt5/mkspecs/modules"
end
