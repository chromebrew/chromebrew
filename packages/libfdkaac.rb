require 'package'

class Libfdkaac < Package
  description 'A standalone library of the Fraunhofer FDK AAC code from Android.'
  homepage 'https://github.com/mstorsjo/fdk-aac/'
  version '0.1.6'
  source_url 'https://github.com/mstorsjo/fdk-aac/archive/v0.1.6.tar.gz'
  source_sha256 'adbcd793e406e1b88b3c1c41382d49f8c27371485b823c0fdab69c9124fd2ce3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfdkaac-0.1.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfdkaac-0.1.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfdkaac-0.1.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfdkaac-0.1.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c75efa60c7bc827c5d14705ae4c16d22e880b748663320259118327d185b3732',
     armv7l: 'c75efa60c7bc827c5d14705ae4c16d22e880b748663320259118327d185b3732',
       i686: '646ee23c1ee24c7d7db11233c967c3bae3b0edef29bdb1d741fb4bcb5f563931',
     x86_64: '6647c1bd76d4ae09c998816512be25d7b3669c1a99fb2959246102a46917ca07',
  })

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
