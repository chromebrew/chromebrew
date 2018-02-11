require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  version '2.4.89'
  source_url 'https://dri.freedesktop.org/libdrm/libdrm-2.4.89.tar.bz2'
  source_sha256 '473997e1fa6f73f75f99bdeb8aa140f7efc3e774988b005c470343ee3cbeb97a'

  binary_url ({
  })
  binary_sha256 ({
  })

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
