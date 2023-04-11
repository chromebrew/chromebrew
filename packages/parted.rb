require 'package'

class Parted < Package
  description 'Create, destroy, resize, check, copy partitions and file systems.'
  homepage 'https://www.gnu.org/software/parted'
  version '3.6'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/parted/parted-3.6.tar.xz'
  source_sha256 '3b43dbe33cca0f9a18601ebab56b7852b128ec1a3df3a9b30ccde5e73359e612'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/parted/3.6_armv7l/parted-3.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/parted/3.6_armv7l/parted-3.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/parted/3.6_i686/parted-3.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/parted/3.6_x86_64/parted-3.6-chromeos-x86_64.tar.zst'
  })
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
