# Adapted from Arch Linux libsixel PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libsixel/trunk/PKGBUILD

require 'package'

class Libsixel < Package
  description 'Provides a codec for DEC SIXEL graphics and some converter programs'
  homepage 'https://github.com/libsixel/libsixel'
  version '1.10.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libsixel/libsixel/archive/v1.10.3.tar.gz'
  source_sha256 '028552eb8f2a37c6effda88ee5e8f6d87b5d9601182ddec784a9728865f821e0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsixel/1.10.3_armv7l/libsixel-1.10.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsixel/1.10.3_armv7l/libsixel-1.10.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsixel/1.10.3_i686/libsixel-1.10.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsixel/1.10.3_x86_64/libsixel-1.10.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e6908061d6984a1ba7dcbe41eadeec82a71bf61bd7046a2f18123be69c8a675a',
     armv7l: 'e6908061d6984a1ba7dcbe41eadeec82a71bf61bd7046a2f18123be69c8a675a',
       i686: '14b320168e6068a82613f5efc498d201020421b2c1681823e5d7653bd62f8f60',
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
