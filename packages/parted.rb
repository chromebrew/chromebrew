require 'buildsystems/autotools'

class Parted < Autotools
  description 'Create, destroy, resize, check, copy partitions and file systems.'
  homepage 'https://www.gnu.org/software/parted/'
  version '3.6-1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/parted/parted-#{version.split('-').first}.tar.xz"
  source_sha256 '3b43dbe33cca0f9a18601ebab56b7852b128ec1a3df3a9b30ccde5e73359e612'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f7ced0862fabff4ab33999d77c751989373349303100516d109120d3997fc67',
     armv7l: '6f7ced0862fabff4ab33999d77c751989373349303100516d109120d3997fc67',
       i686: 'ba42ce65f733742403ead3a05658ab5305825bec4df89b118f9387a3d82a68cd',
     x86_64: '9f5c1053aa58626f1d6d3cdad28957c1dbc4e417c1e3d3a3af06160433ddda84'
  })

  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lvm2' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R
  depends_on 'util_linux' # R
end
