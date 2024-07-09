require 'buildsystems/cmake'

class Libxml2 < CMake
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2'
  version '2.13.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb69071220e11d4f0fd61895b6c46e4be71ec34a0c8a33ff991180437c83f2b9',
     armv7l: 'eb69071220e11d4f0fd61895b6c46e4be71ec34a0c8a33ff991180437c83f2b9',
       i686: '199c9ec45327f3be3f402f08023fea2cd9dc1f04ca65e5eac0a2018a26dfd41b',
     x86_64: '91e68d3cf4eb408735aca931cbe23d7c52dc5f9d3e9084255910d203443507fe'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R
  depends_on 'zlibpkg' # R

  cmake_options '-DLIBXML2_WITH_PYTHON=OFF -DLIBXML2_WITH_ICU=ON'
end
