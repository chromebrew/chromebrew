require 'package'

class Socat < Package
  description 'SOcket CAT is a multipurpose relay \'netcat++\' (extended design, new implementation).'
  homepage 'http://www.dest-unreach.org/socat/'
  version '1.7.3.2'
  compatibility 'all'
  source_url 'http://www.dest-unreach.org/socat/download/socat-1.7.3.2.tar.gz'
  source_sha256 'ce3efc17e3e544876ebce7cd6c85b3c279fda057b2857fcaaf67b9ab8bdaf034'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/socat-1.7.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/socat-1.7.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/socat-1.7.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/socat-1.7.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '091cdca4b501c08aca4884f2df0772cb7f974ce506c14a958088c4f7a22be634',
     armv7l: '091cdca4b501c08aca4884f2df0772cb7f974ce506c14a958088c4f7a22be634',
       i686: '4138f1fc6642f5bdbe3b6316bb3b77fd49cd0dd97961509f70d2ab4aa98f7b04',
     x86_64: 'dbc08fb0daf806448fbb307021f2934fb07bf58c8ff3dc4c54bee8127b80c202',
  })

  depends_on 'readline'
  depends_on 'openssl'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
