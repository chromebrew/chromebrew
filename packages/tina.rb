require 'buildsystems/autotools'

class Tina < Autotools
  description 'Tina is a personal information manager with a curses interface.'
  homepage 'https://devel.ringlet.net/misc/tina/'
  version '0.1.14'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://devel.ringlet.net/files/misc/tina/tina-#{version}.tar.xz"
  source_sha256 'eae5b5dfe71005c8ec24cee0b69c4b2da8fb45061a543e48a6599e4b54a8fcec'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd19a814b70e60892e1123d1728efe97514d0c81f26235d897de36e8735541e2f',
     armv7l: 'd19a814b70e60892e1123d1728efe97514d0c81f26235d897de36e8735541e2f',
       i686: 'c19a7a470ff27131fd94a1221933d11a1125c4aa6b622063bd9f31e5446dd14a',
     x86_64: '6216d2d92fc5197c84da22909fa3d534f7f00e787aaa580b941bf0b605da4244'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  autotools_pre_configure_options "CFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
end
