require 'buildsystems/autotools'

class Htop < Autotools
  description 'htop is an interactive process viewer for Unix systems.'
  homepage 'https://github.com/htop-dev/htop'
  version '3.5.0'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/htop-dev/htop.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab699c97b69070a6e5caf4052d1bdcb415e3b8474c8690aac3dec82856c8ec38',
     armv7l: 'ab699c97b69070a6e5caf4052d1bdcb415e3b8474c8690aac3dec82856c8ec38',
       i686: '7e7ff242ef5bafe1edac00f7cdf5dcd291ea59fb31d638bc6025c5a3c79e279e',
     x86_64: '2e352c4d0179468aa28180ed9ef9f5ee4be3dea358b01b2be9e1ece03df6f608'
  })

  depends_on 'buildessential' => :build
  depends_on 'glibc' => :library
  depends_on 'libcap' => :library
  depends_on 'libnl3' => :library
  depends_on 'libunwind' => :library
  depends_on 'ncurses' => :library

  autotools_pre_configure_options "CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
  autotools_configure_options '--disable-unicode'
end
