require 'package'

class Expect < Package
  description 'Expect is a tool for automating interactive applications such as telnet, ftp, passwd, fsck, rlogin, tip, etc.'
  homepage 'http://expect.sourceforge.net/'
  version '5.45.4'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/expect/Expect/5.45.4/expect5.45.4.tar.gz'
  source_sha256 '49a7da83b0bdd9f46d04a04deec19c7767bb9a323e40c4781f89caf760b92c34'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/expect-5.45.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/expect-5.45.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/expect-5.45.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/expect-5.45.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7ec75d2e1b62aca345b82b88820a0a7e06cfc25163f39d324acb9a723420e819',
     armv7l: '7ec75d2e1b62aca345b82b88820a0a7e06cfc25163f39d324acb9a723420e819',
       i686: '4031c72d5516dff5a8655d820ff10095a47e2978fc00607235736d2d56380e45',
     x86_64: 'ccdf8484e01563ffce6f5f112340948e06ce6a71a8cb3afc22d8cea0fb15c9fe',
  })

  depends_on 'tcl'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make test"
  end
end
