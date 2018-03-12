require 'package'

class Dri3proto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.0-0'
  source_url 'https://www.x.org/archive/individual/proto/dri3proto-1.0.tar.gz'
  source_sha256 'e1a0dad3009ecde52c0bf44187df5f95cc9a7cc0e76dfc2f2bbf3e909fe03fa9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dri3proto-1.0-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dri3proto-1.0-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dri3proto-1.0-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dri3proto-1.0-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: '9c4792075566afae8b7993246fe797c209abaa7c9b706fb22b9fa2e698310cff',
     armv7l: '9c4792075566afae8b7993246fe797c209abaa7c9b706fb22b9fa2e698310cff',
       i686: '413a843bcee11fbd64632a115fe9de0ce97df4522c94332b6242613d921751e2',
     x86_64: 'bcad3f30a5300bbae522fb7f46945d3b05d50136c9380228208b66a40ec15be6',

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
