require 'package'

class Libxxf86vm < Package
  description 'X.org the client library for the XFree86-VidMode X extension.'
  homepage 'http://www.x.org'
  version '1.1.4-0'
  compatibility 'all'
  source_url 'https://www.x.org/archive//individual/lib/libXxf86vm-1.1.4.tar.gz'
  source_sha256 '5108553c378a25688dcb57dca383664c36e293d60b1505815f67980ba9318a99'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86vm-1.1.4-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86vm-1.1.4-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86vm-1.1.4-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86vm-1.1.4-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '62379cfc00fd66e76b81b93be0e79d68b2749fa79f162addc3745c2ecd452019',
     armv7l: '62379cfc00fd66e76b81b93be0e79d68b2749fa79f162addc3745c2ecd452019',
       i686: '81582f8aa29eebd0e83f186e1679fba7706e286deb0bf09d887496fc1a6d6c97',
     x86_64: 'a841de7f515f3eff18afc1bc746e2b9c7f6146108fa6ddc9d76439d3d20374ed',
  })

  depends_on 'libxext'
  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
