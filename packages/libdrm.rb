require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  version '2.4.100'
  source_url 'https://dri.freedesktop.org/libdrm/libdrm-2.4.100.tar.gz'
  source_sha256 '6a5337c054c0c47bc16607a21efa2b622e08030be4101ef4a241c5eb05b6619b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.100-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.100-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.100-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.100-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fee93a19fd4d5d628aa4f6f79e37e8104898682391079a2e82aca08254b1405e',
     armv7l: 'fee93a19fd4d5d628aa4f6f79e37e8104898682391079a2e82aca08254b1405e',
       i686: 'dcb2149ae24d18163ee3885113908d6ff529e1bf5c311e219e7bc4e216b53467',
     x86_64: '88c588ff6dc9d1afa772d5ebe93f8f2a0a924f2efd229db732f25126cc482c9a',
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
