require 'package'

class Applewmproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.4.2-0'
  source_url 'https://www.x.org/archive/individual/proto/applewmproto-1.4.2.tar.gz'
  source_sha256 'ff8ac07d263a23357af2d6ff0cca3c1d56b043ddf7797a5a92ec624f4704df2e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/applewmproto-1.4.2-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/applewmproto-1.4.2-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/applewmproto-1.4.2-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/applewmproto-1.4.2-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6a52f1671aff5397fc95944083b48781cc6b4245c3e724004f56bdd0fd7a4d37',
     armv7l: '6a52f1671aff5397fc95944083b48781cc6b4245c3e724004f56bdd0fd7a4d37',
       i686: '99b3bbc94cf892d8351438a5117a39870b55131968964b41ce29e59335ffe5fb',
     x86_64: '2004a85dce02d48cf0af221a8a1d45b1eba66f3e3339149866d3b714b53fe142',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
