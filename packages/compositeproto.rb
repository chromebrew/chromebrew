require 'package'

class Compositeproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '0.4-0'
  source_url 'https://www.x.org/archive/individual/proto/compositeproto-0.4.tar.gz'
  source_sha256 '1607f58409185203077de59801970b07a36f41e586a499918284c8d768d870cc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/compositeproto-0.4-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/compositeproto-0.4-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/compositeproto-0.4-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/compositeproto-0.4-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '83155adfc3e02dcdee5ce5e6cc5561186b323d4e929fdf088217fe3aea6e3dce',
     armv7l: '83155adfc3e02dcdee5ce5e6cc5561186b323d4e929fdf088217fe3aea6e3dce',
       i686: '28b524a41fe1fe5371cba7af5032065e3d3a5b54b89df91f6cdc029118a46c45',
     x86_64: 'b772221a1399f52ae5afab82655208409ff6683d4077668212ad4cd8480a49a4',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
