require 'buildsystems/autotools'

class Htop < Autotools
  description 'htop is an interactive process viewer for Unix systems.'
  homepage 'https://github.com/htop-dev/htop'
  version '3.5.2'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/htop-dev/htop.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bc133486ff42a9d08c0243fb0956c0bedc6fef6fd03d89f9a16d44a7c3d9e7ab',
     armv7l: 'bc133486ff42a9d08c0243fb0956c0bedc6fef6fd03d89f9a16d44a7c3d9e7ab',
       i686: '30c4fec2e5074aca4114a7af708fb79872c68be573a3afddeff72ac4b6bde182',
     x86_64: 'c7b1f5400efeeaa58026830db71c55dd79dec0630fe98ad64347082ec3d7a409'
  })

  depends_on 'glibc' => :executable
  depends_on 'libcap' => :executable
  depends_on 'libnl3' => :build
  depends_on 'libunwind' => :executable
  depends_on 'ncurses' => :executable

  autotools_pre_configure_options "CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
  autotools_configure_options '--disable-unicode'
end
