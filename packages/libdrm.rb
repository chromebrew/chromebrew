require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  version '2.4.91'
  source_url 'https://dri.freedesktop.org/libdrm/libdrm-2.4.91.tar.bz2'
  source_sha256 '634a0ed0cc1eff06f48674b1da81aafa661a9f001e7a4f43dde81076886dc800'

  depends_on 'libpciaccess'
  depends_on 'xorg_lib' => :build

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
