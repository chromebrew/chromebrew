require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  version '2.4.91'
  source_url 'https://dri.freedesktop.org/libdrm/libdrm-2.4.91.tar.bz2'
  source_sha256 '634a0ed0cc1eff06f48674b1da81aafa661a9f001e7a4f43dde81076886dc800'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.91-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.91-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.91-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.91-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4489dc1f2a45a7a3c0b5d5245672b29b134b108208aadcc7d684b3a8547202a7',
     armv7l: '4489dc1f2a45a7a3c0b5d5245672b29b134b108208aadcc7d684b3a8547202a7',
       i686: 'b96e268dfc9a04bf9482c216110c18a75a643dd0ef21e95b3367c8f42b6caf45',
     x86_64: '4bfe97f39a465077ecb2d24d9a6da5cf1f2bba1a4dcabb93fc7bea34cdf95db7',
  })

  depends_on 'libpciaccess'
  depends_on 'xorg_lib' => :build
  depends_on 'eudev'

  def self.build
    case ARCH
      when 'x86_64', 'i686'
        system "./configure \
                --prefix=#{CREW_PREFIX} \
                --libdir=#{CREW_LIB_PREFIX} \
                --enable-vmwgfx \
                --enable-nouveau \
                --enable-udev"  
      when 'aarch64', 'armv7l'
         system "./configure \
                --prefix=#{CREW_PREFIX} \
                --libdir=#{CREW_LIB_PREFIX} \
                --enable-nouveau \
                --enable-tegra-experimental-api \
                --enable-exynos-experimental-api \
                --enable-vc4 \
                --enable-udev"
      end
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
