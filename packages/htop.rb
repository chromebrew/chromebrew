require 'buildsystems/autotools'

class Htop < Autotools
  description 'htop is an interactive process viewer for Unix systems.'
  homepage 'https://github.com/htop-dev/htop'
  version '3.5.1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/htop-dev/htop.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02f046b1c6b12309b646e917820a44415fa81971d8b5cc7f985154624660b3a1',
     armv7l: '02f046b1c6b12309b646e917820a44415fa81971d8b5cc7f985154624660b3a1',
       i686: 'e649d7a79c5dbf1a623b2f9cb42278b926c72d9d4cd47c5d742152c96582381f',
     x86_64: '11f99378be6f5e439fa66baae3ca77f152cf89cd1b484931a6b69e126688b102'
  })

  depends_on 'glibc' => :executable
  depends_on 'libcap' => :executable
  depends_on 'libnl3' => :build
  depends_on 'libunwind' => :executable
  depends_on 'ncurses' => :executable

  autotools_pre_configure_options "CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
  autotools_configure_options '--disable-unicode'
end
