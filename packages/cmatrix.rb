require 'package'

class Cmatrix < Package
  description "CMatrix is a program to see the cool scrolling lines from 'The Matrix' movie."
  homepage 'http://www.asty.org/cmatrix/'
  version '1.2a-1'
  source_url 'http://www.asty.org/cmatrix/dist/cmatrix-1.2a.tar.gz'
  source_sha256 '1fa6e6caea254b6fe70a492efddc1b40ad7ccb950a5adfd80df75b640577064c'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/cmatrix-1.2a-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/cmatrix-1.2a-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/cmatrix-1.2a-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/cmatrix-1.2a-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cd094b3ef03e1f1c47d7d1784549a6ded9ccfb59b2fb4546a5b4b99ce011a954',
     armv7l: 'cd094b3ef03e1f1c47d7d1784549a6ded9ccfb59b2fb4546a5b4b99ce011a954',
       i686: '9e97e2fa6ef0a384223b2c456905e5955a2355967f7ca14fcd98b0ebeeb651a3',
     x86_64: 'a846151b32138a8b0803b3e40dda4d42e804d093dab1105787578714e144131b',
  })

  depends_on 'buildessential'
  depends_on 'ncurses'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses ./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
