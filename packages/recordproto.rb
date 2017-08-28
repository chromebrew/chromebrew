require 'package'

class Recordproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.14'
  source_url 'https://www.x.org/archive/individual/proto/recordproto-1.14.tar.gz'
  source_sha256 '74fc0e8919f3c234848794f1ee266ba6d090f9b99fd65ab913c54ee3ad3ff377'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/recordproto-1.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/recordproto-1.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/recordproto-1.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/recordproto-1.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9a678d4dbf0ab327462fea060cbbf9a32a06d6bc88385bf31b7e92b950ba9d13',
     armv7l: '9a678d4dbf0ab327462fea060cbbf9a32a06d6bc88385bf31b7e92b950ba9d13',
       i686: 'edc33d494671906c1e4bdafab208bb9c79850845685f366af43fdf076ddadd2a',
     x86_64: 'ba204da29b67fedd013f5156a557043f789e220b7321a7ea4d45dc1f60cfdec4',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
