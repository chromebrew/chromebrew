require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  version '2.4.96'
  source_url 'https://dri.freedesktop.org/libdrm/libdrm-2.4.96.tar.bz2'
  source_sha256 '0d561acf7bb4cc59dc82415100e6c1a44860e8c380e00f9592923e3cd08db393'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.96-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.96-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.96-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.96-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '80eb0b1bdf0217ed2f7af5d023c4bfe45619a8d52aceab7aa7dde65d0362b736',
     armv7l: '80eb0b1bdf0217ed2f7af5d023c4bfe45619a8d52aceab7aa7dde65d0362b736',
       i686: '4d8ad13d4ff5b4cc8037be4835de73dffb0be56be0e93a3431d886701ef43d77',
     x86_64: 'ecdc554b5bb6dd8fbf16862803e6b4ce78cec9f4a71fe6809e731363abd5fb12',
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
