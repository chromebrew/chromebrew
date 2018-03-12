require 'package'

class Trapproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '3.4.3-0'
  source_url 'https://www.x.org/archive/individual/proto/trapproto-3.4.3.tar.gz'
  source_sha256 'abfb930b5703b5a6ebafe84d0246bd8c6b099ca4a4eab06d1dc0776a8a9b87c1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/trapproto-3.4.3-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/trapproto-3.4.3-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/trapproto-3.4.3-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/trapproto-3.4.3-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c5c5bf4dd46fd7b9e3a1f44e669924956c25808e4fef070a7b81c6a5903d0bbd',
     armv7l: 'c5c5bf4dd46fd7b9e3a1f44e669924956c25808e4fef070a7b81c6a5903d0bbd',
       i686: '28a37b10bb7918b386007780b6af40fbdb8dab2519068eaefb672e733c7b8e26',
     x86_64: '6bf5827681f558770f3205d94d60392b587ad8d99d26a5c8da63263227c58b53',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
