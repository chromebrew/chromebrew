require 'buildsystems/autotools'

class Htop < Autotools
  description 'htop is an interactive process viewer for Unix systems.'
  homepage 'https://github.com/htop-dev/htop'
  version '3.5.3'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/htop-dev/htop.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f3d03b205709c7ea8e581650d589c69b4f2a93b0c824b1aba6afef96777e6dd',
     armv7l: '0f3d03b205709c7ea8e581650d589c69b4f2a93b0c824b1aba6afef96777e6dd',
       i686: '0e18a86bcb047459002cc13be6f1df664d1ed03876ac695411cfafb3aa23fff4',
     x86_64: '801741c7c5a3565039cb04e507394fdbddf3c82883dbb2a4522933fad636f942'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libcap' => :executable
  depends_on 'libnl3' => :build
  depends_on 'libunwind' => :executable
  depends_on 'ncurses' => :executable

  autotools_pre_configure_options "CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
  autotools_configure_options '--disable-unicode'
end
