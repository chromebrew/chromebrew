require 'package'

class Kbproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.0.7-0'
  source_url 'https://www.x.org/archive/individual/proto/kbproto-1.0.7.tar.gz'
  source_sha256 '828cb275b91268b1a3ea950d5c0c5eb076c678fdf005d517411f89cc8c3bb416'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/kbproto-1.0.7-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/kbproto-1.0.7-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/kbproto-1.0.7-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/kbproto-1.0.7-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2f3055802585890a49beed1fe44858073da2f2d9ae7ed369ab12bacd1ff6cc8e',
     armv7l: '2f3055802585890a49beed1fe44858073da2f2d9ae7ed369ab12bacd1ff6cc8e',
       i686: 'a1acdf261a592617b8b3f30cf872ba7ff01e504d526798a211e31ade31c38bbf',
     x86_64: '0b14c76c46dbb9178da178c5368aaa8e5c4aedc89330767c8f0362ed456758b0',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
