require 'package'

class Libvdpau < Package
  description 'VDPAU is the Video Decode and Presentation API for UNIX. It provides an interface to video decode acceleration and presentation hardware present in modern GPUs.'
  homepage 'https://www.freedesktop.org/wiki/Software/VDPAU/'
  version '1.1.1'
  source_url 'https://gitlab.freedesktop.org/vdpau/libvdpau/uploads/5635163f040f2eea59b66d0181cf664b/libvdpau-1.1.1.tar.bz2'
  source_sha256 '857a01932609225b9a3a5bf222b85e39b55c08787d0ad427dbd9ec033d58d736'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libvdpau-1.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libvdpau-1.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libvdpau-1.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libvdpau-1.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7294f6d6e5658a671f2c200b927ce8af3eec5e29be48617ccd159b7cb4be4e0f',
     armv7l: '7294f6d6e5658a671f2c200b927ce8af3eec5e29be48617ccd159b7cb4be4e0f',
       i686: '0f1e80786ef70a10d1a75b0f22e038183eaf4e56c5f83f8db1ad42f9fad57a14',
     x86_64: '2fd6efe5954f031570115bf0c32e03baf9418162e8f61df544f36231e902e3e1',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
