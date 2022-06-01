# Adapted from Arch Linux fig2dev PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/fig2dev/trunk/PKGBUILD

require 'package'

class Fig2dev < Package
  description 'Format conversion utility that can be used with xfig'
  homepage 'http://mcj.sourceforge.net/'
  version '3.2.8b'
  license 'custom'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/mcj/fig2dev-#{version}.tar.xz"
  source_sha256 '418a164aa9fad72d25bb4fec8d7b452fe3a2f12f990cf22e05c0eb16cecb68cb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fig2dev/3.2.8b_armv7l/fig2dev-3.2.8b-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fig2dev/3.2.8b_armv7l/fig2dev-3.2.8b-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fig2dev/3.2.8b_i686/fig2dev-3.2.8b-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fig2dev/3.2.8b_x86_64/fig2dev-3.2.8b-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7d58afbf61ec04863fb2c9c1c3f604a5f585ca0e3927e88de1c350497bb5c916',
     armv7l: '7d58afbf61ec04863fb2c9c1c3f604a5f585ca0e3927e88de1c350497bb5c916',
       i686: 'ca06980b6095bddc69acfc9f9cc5b1ef42d6d60b3f2c0d4e36c55c57090db2af',
     x86_64: '4a08b8d9b7a40236308af595d94f08e9043bb7f526fdbc51125768eef21efbba'
  })

  depends_on 'libpng'
  depends_on 'libxpm'
  depends_on 'bc'
  depends_on 'netpbm'
  depends_on 'ghostscript'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure \
      #{CREW_OPTIONS} \
      --enable-transfig"
    system "make FIG2DEV_LIBDIR=#{CREW_PREFIX}/share/fig2dev \
      XFIGLIBDIR=#{CREW_PREFIX}/share/xfig"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} \
    XFIGLIBDIR=#{CREW_PREFIX}/share/xfig \
    FIG2DEV_LIBDIR=#{CREW_PREFIX}/share/fig2dev \
    MANPATH=#{CREW_MAN_PREFIX} \
    install"
  end
end
