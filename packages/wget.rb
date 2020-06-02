require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '1.20.3-2'
  source_url 'https://ftpmirror.gnu.org/wget/wget-1.20.3.tar.lz'
  source_sha256 '69607ce8216c2d1126b7a872db594b3f21e511e660e07ca1f81be96650932abb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.20.3-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.20.3-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.20.3-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.20.3-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '09cdb1dddd02bd54e680dd2a964c7fed8bfdf4ce265246e4b7e794185e8a85e7',
     armv7l: '09cdb1dddd02bd54e680dd2a964c7fed8bfdf4ce265246e4b7e794185e8a85e7',
       i686: 'c39c733bbc1bf34dd3c841086a02d9ff84deba16b0567a7a8c78455cfd04df23',
     x86_64: '161c5298eac67dbe5c3165294f2d7d6392ee7608b8aed75aa6c156323cbee9a1',
  })

  depends_on 'gnutls'
  depends_on 'libpsl'
  depends_on 'libmetalink'

  def self.build
    system "./configure #{CREW_OPTIONS} --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.check
    #system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
