require 'package'

class Inputproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.3-0'
  source_url 'https://www.x.org/archive/individual/proto/inputproto-2.3.tar.gz'
  source_sha256 '98e8ab87fb71080b28536d749aa942bdad13d860d5eb3e1271084906cda711e9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/inputproto-2.3-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/inputproto-2.3-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/inputproto-2.3-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/inputproto-2.3-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '089774964d50323df9078b0f71b762f9577c3cfcb2684e854ffa406bb4bf59bd',
     armv7l: '089774964d50323df9078b0f71b762f9577c3cfcb2684e854ffa406bb4bf59bd',
       i686: '31293052bf6c4a251856359186a1b83336b2f60b523cdae9029f36099c0c9719',
     x86_64: 'fa44f6c8878988e157bc60ad749a80682c986ef797a906f2270f8d61bc43789b',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
