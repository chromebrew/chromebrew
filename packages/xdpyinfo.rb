# Adapted from Arch Linux xorg-xdpyinfo PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/xorg-xdpyinfo/trunk/PKGBUILD

require 'package'

class Xorg_xdpyinfo < Package
  description 'Display information utility for X'
  version '1.3.2-4'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/archive/individual/app/xdpyinfo-1.3.2.tar.bz2'
  source_sha256 '30238ed915619e06ceb41721e5f747d67320555cc38d459e954839c189ccaf51'

  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxtst'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'
  depends_on 'libxcomposite'
  depends_on 'libxinerama'
  depends_on 'xorg_proto' 

        def self.build
                system "./configure #{CREW_OPTIONS}"
                system 'make'
        end
        
        def self.install
                system "make DESTDIR=#{CREW_DEST_DIR} install"
        end
end
