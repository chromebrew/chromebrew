require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (VIdeo Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  version '2.6.1'
  compatibility 'all'
  source_url 'https://github.com/intel/libva/releases/download/2.6.1/libva-2.6.1.tar.bz2'
  source_sha256 '6c57eb642d828af2411aa38f55dc10111e8c98976dbab8fd62e48629401eaea5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '29fa0f07bfd42af85d748a7e3824ef0dc87d8c13ea39f834350ce049412fb074',
     armv7l: '29fa0f07bfd42af85d748a7e3824ef0dc87d8c13ea39f834350ce049412fb074',
       i686: '0023ca0203c0d44922f86d4f72fb5ab836ad99565ace968d6e5f925fc93f99d2',
     x86_64: '67b40e1c110c7fbcf55944ff45e1bb1a39fc9bc81e95b0e52726516376f272a6',
  })

  depends_on 'libdrm'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
