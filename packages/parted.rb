require 'package'

class Parted < Package
  description 'Create, destroy, resize, check, copy partitions and file systems.'
  homepage 'https://www.gnu.org/software/parted'
  @_ver = '3.4-1'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/parted/parted-#{@_ver}.tar.xz"
  source_sha256 'e1298022472da5589b7f2be1d5ee3c1b66ec3d96dfbad03dc642afd009da5342'

  depends_on 'lvm2'
  depends_on 'ncursesw'
  depends_on 'readline'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' \
                CXXFLAGS='-pipe -flto=auto' \
                LDFLAGS='-flto=auto' \
            ./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
