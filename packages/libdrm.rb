require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  version '2.4.96'
  source_url 'https://dri.freedesktop.org/libdrm/libdrm-2.4.96.tar.bz2'
  source_sha256 '0d561acf7bb4cc59dc82415100e6c1a44860e8c380e00f9592923e3cd08db393'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libpciaccess'
  depends_on 'xorg_lib'
  depends_on 'eudev'
  depends_on 'libxslt'

  def self.build
    system "./configure",
           "--enable-etnaviv-experimental-api",
           "--enable-exynos-experimental-api",
           "--enable-tegra-experimental-api",
           "--enable-omap-experimental-api",
           "--enable-install-test-programs",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--prefix=#{CREW_PREFIX}",
           "--enable-freedreno-kgsl",
           "--enable-freedreno",
           "--enable-manpages",
           "--enable-nouveau",
           "--enable-amdgpu",
           "--enable-vmwgfx",
           "--enable-intel",
           "--enable-udev",
           "--enable-vc4"  
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
