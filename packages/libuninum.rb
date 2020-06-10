require 'package'

class Libuninum < Package
  description 'This is a library for converting Unicode strings to numbers and numbers to Unicode strings.'
  homepage 'http://billposer.org/Software/libuninum.html'
  version '2.7-0'
  compatibility 'all'
  source_url 'https://billposer.org/Software/Downloads/libuninum-2.7.tar.bz2'
  source_sha256 'e704983c3c00e9b76bd836b8b83ce31bfe4eb1752eee8be123cf97c1275076ea'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libuninum-2.7-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libuninum-2.7-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libuninum-2.7-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libuninum-2.7-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8cca34b8e60fed8fd5f8506f4b91ababb6343fb89a268a03fb590ebf44f29cef',
     armv7l: '8cca34b8e60fed8fd5f8506f4b91ababb6343fb89a268a03fb590ebf44f29cef',
       i686: '36aad93b00c85623884776b89dab2dde5c7e8ef393b13b9faf4b175ea2787704',
     x86_64: 'f2119fada66d21f242a33068c46267c1f05cdcb517dcbe76ab9476ca556e22cc',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
