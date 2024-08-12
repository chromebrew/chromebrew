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
    aarch64: '10b5f4e92420facec657e47fc7a0cd125865be73178438048c64d630e4431f0b',
     armv7l: '10b5f4e92420facec657e47fc7a0cd125865be73178438048c64d630e4431f0b',
       i686: '98e31203e235435193ceb18a1a890bf5d8763266e29b7049056ecd9ffd145cf3',
     x86_64: '9f5c1053aa58626f1d6d3cdad28957c1dbc4e417c1e3d3a3af06160433ddda84'
  })

  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lvm2' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R
  depends_on 'util_linux' # R
end
