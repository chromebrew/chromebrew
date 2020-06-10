require 'package'

class M4 < Package
  description 'GNU M4 is an implementation of the traditional Unix macro processor.'
  homepage 'https://www.gnu.org/software/m4/'
  version '1.4.18'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.xz'
  source_sha256 'f2c1e86ca0a404ff281631bdc8377638992744b175afb806e25871a24a934e07'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/m4-1.4.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/m4-1.4.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/m4-1.4.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/m4-1.4.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '57b2c4f5bc8ef5cc680e97e878d79382f3cfd2b1e54679cae269bf968cd72316',
     armv7l: '57b2c4f5bc8ef5cc680e97e878d79382f3cfd2b1e54679cae269bf968cd72316',
       i686: 'd67fafe955ee4cdabad4b17df7a402409fc3a8fffe27671d350073ac5312688e',
     x86_64: 'd364c72f7cf138bf120aa18a5a0b1e4500b50f79bc927f435c468cbd4bf4cc9b',
  })

  depends_on 'libsigsegv'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make check"
  end
end
