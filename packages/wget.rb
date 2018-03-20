require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '1.19.4'
  source_url 'https://ftpmirror.gnu.org/wget/wget-1.19.tar.xz'
  source_sha256 '0f1157bbf4daae19f3e1ddb70c6ccb2067feb834a6aa23c9d9daa7f048606384'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.19.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.19.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.19.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.19.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bab5af68ea69bfe5bd74d533fa6f7f5fefa428ac05c8e505f9725ac3deb7c56d',
     armv7l: 'bab5af68ea69bfe5bd74d533fa6f7f5fefa428ac05c8e505f9725ac3deb7c56d',
       i686: '6019d23e65947cae46590465e653d556a42a6ee987d20bd617e32ba79f5a4521',
     x86_64: '31077b80d13d573384154a222a490bb97d640e85fc0c8e0c444568a01e4f4df4',
  })

  depends_on 'gnutls'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      "--sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
