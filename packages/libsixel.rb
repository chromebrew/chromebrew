# Adapted from Arch Linux libsixel PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libsixel/trunk/PKGBUILD

require 'package'

class Libsixel < Package
  description 'Provides a codec for DEC SIXEL graphics and some converter programs'
  homepage 'https://github.com/libsixel/libsixel'
  version '1.10.3'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/libsixel/libsixel/archive/v1.10.3.tar.gz'
  source_sha256 '028552eb8f2a37c6effda88ee5e8f6d87b5d9601182ddec784a9728865f821e0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e6908061d6984a1ba7dcbe41eadeec82a71bf61bd7046a2f18123be69c8a675a',
     armv7l: 'e6908061d6984a1ba7dcbe41eadeec82a71bf61bd7046a2f18123be69c8a675a',
     x86_64: '16d7382c5229870d3954338748174d402db8542408b33bea49e6c3066a9c942a'
  })

  depends_on 'libjpeg' => :build
  depends_on 'libpng' => :build
  depends_on 'python3' => :build
  depends_on 'gdk_pixbuf' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
       -Dgdk-pixbuf2=enabled \
       builddir"
    system 'meson configure --no-pager builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
