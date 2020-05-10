require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '1.20.3-1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/wget/wget-1.20.3.tar.lz'
  source_sha256 '69607ce8216c2d1126b7a872db594b3f21e511e660e07ca1f81be96650932abb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.20.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.20.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.20.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.20.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '65aa64df68aaf4e118e49e245aefea2212ad90ba77600e45eae3495834049346',
     armv7l: '65aa64df68aaf4e118e49e245aefea2212ad90ba77600e45eae3495834049346',
       i686: '48430293642a695f6ebe403f745d56195852fd993180edde92801d109eb2cce8',
     x86_64: 'c3d9476f3d7cc180166e3d2e5da863dd74963e41243fc96df285ac39b69d345e',
  })

  depends_on 'gnutls'
  depends_on 'libpsl'
  depends_on 'libmetalink'

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
