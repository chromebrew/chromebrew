require 'package'

class Recordproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.14-0'
  source_url 'https://www.x.org/archive/individual/proto/recordproto-1.14.tar.gz'
  source_sha256 '74fc0e8919f3c234848794f1ee266ba6d090f9b99fd65ab913c54ee3ad3ff377'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/recordproto-1.14-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/recordproto-1.14-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/recordproto-1.14-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/recordproto-1.14-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: 'f39628b4dcea6d60fb8037fdb435c6beb004fa2fba1de6003a5f96ad3d548f1e',
     armv7l: 'f39628b4dcea6d60fb8037fdb435c6beb004fa2fba1de6003a5f96ad3d548f1e',
       i686: 'fd4f1d0c0d45eccef91286123e72b226cb2f45511ca2dcefba279340f5dc2f76',
     x86_64: 'c1915215292ef7657b69ec7c567b45d1a379ed0086484152198a07b444f13a42',

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
