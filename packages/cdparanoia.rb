# Adapted from Arch Linux cdparanoia PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/cdparanoia/trunk/PKGBUILD

require 'package'

class Cdparanoia < Package
  description 'Compact Disc Digital Audio extraction tool'
  homepage 'https://www.xiph.org/paranoia/'
  version '10.2'
  license 'GPL'
  compatibility 'all'
  source_url 'https://downloads.xiph.org/releases/cdparanoia/cdparanoia-III-10.2.src.tgz'
  source_sha256 '005db45ef4ee017f5c32ec124f913a0546e77014266c6a1c50df902a55fe64df'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '355295c34b89f75440bcd3aa003d1c4132dce8bf68b11bc164031f25086ae573',
     armv7l: '355295c34b89f75440bcd3aa003d1c4132dce8bf68b11bc164031f25086ae573',
       i686: '74db8c9126b6dc858120def2a959205c5189e85a01232a18f31a90c8423c80b7',
     x86_64: '1cc714af1c8617cc10a6bc893e17beece810f851057a444e1813d79f495ceafe'
  })

  depends_on 'glibc'

  no_lto

  def self.patch
    downloader 'https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/cdparanoia/trunk/gcc.patch',
               '9a3f3802856e96080fb30562a10899ef3378723e85f289fa29619b21d6051575'
    system 'patch -Np0 -i gcc.patch'
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make -j1'
  end

  def self.install
    system "make prefix=#{CREW_DEST_PREFIX} \
      MANDIR=#{CREW_DEST_MAN_PREFIX} \
      LIBDIR=#{CREW_DEST_LIB_PREFIX} \
      install"
  end
end
