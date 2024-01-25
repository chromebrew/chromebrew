require 'package'

class Parted < Package
  description 'Create, destroy, resize, check, copy partitions and file systems.'
  homepage 'https://www.gnu.org/software/parted'
  version '3.6'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/parted/parted-3.6.tar.xz'
  source_sha256 '3b43dbe33cca0f9a18601ebab56b7852b128ec1a3df3a9b30ccde5e73359e612'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '10b5f4e92420facec657e47fc7a0cd125865be73178438048c64d630e4431f0b',
     armv7l: '10b5f4e92420facec657e47fc7a0cd125865be73178438048c64d630e4431f0b',
       i686: 'ba42ce65f733742403ead3a05658ab5305825bec4df89b118f9387a3d82a68cd',
     x86_64: '9f5c1053aa58626f1d6d3cdad28957c1dbc4e417c1e3d3a3af06160433ddda84'
  })

  depends_on 'lvm2'
  depends_on 'ncurses'
  depends_on 'readline'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
