require 'package'

class Krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  version '1.16'
  compatibility 'all'
  source_url 'http://web.mit.edu/kerberos/dist/krb5/1.16/krb5-1.16.tar.gz'
  source_sha256 'faeb125f83b0fb4cdb2f99f088140631bb47d975982de0956d18c85842969e08'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/krb5-1.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bcb8897583e93562cc1fc0c16fdb712dfa464d833c6aac83a668201763d6deeb',
     armv7l: 'bcb8897583e93562cc1fc0c16fdb712dfa464d833c6aac83a668201763d6deeb',
       i686: '15ce6e5b300eb7b050c3495b99aaa91c07166144783a20d9278457215bf22c52',
     x86_64: 'fb5fb9ad6e393104a31c1ef29208840720b796555fa9f7ccd0bbd0412e44495e',
  })

  depends_on 'gawk'

  def self.build
    Dir.chdir "src" do
      system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      "--without-system-verto"
      system "make"
    end
  end

  def self.install
    Dir.chdir "src" do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
