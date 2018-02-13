require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  version '2.4.89'
  source_url 'https://dri.freedesktop.org/libdrm/libdrm-2.4.89.tar.bz2'
  source_sha256 '629f9782aabbb4809166de5f24d26fe0766055255038f16935602d89f136a02e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.89-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.89-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.89-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.89-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '975d1f44f905ea2e2a26949ef733e4a02c49b13b393be3df329b87ed1c424a67',
     armv7l: '975d1f44f905ea2e2a26949ef733e4a02c49b13b393be3df329b87ed1c424a67',
       i686: '3812c5436bd7f07eae816037f2e68bfd11156dc3fa832bddbfbc4a2ef1f36cdd',
     x86_64: '515b36a63ade23b47036f3020b38ff99f8267662c1af9669f0487d9f4a05af41',
  })

  depends_on 'libpciaccess'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --enable-tegra-experimental-api \
            --enable-exynos-experimental-api \
            --enable-udev"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
