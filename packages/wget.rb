require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '1.20.3-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/wget/wget-1.20.3.tar.lz'
  source_sha256 '69607ce8216c2d1126b7a872db594b3f21e511e660e07ca1f81be96650932abb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.20.3-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.20.3-3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.20.3-3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.20.3-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '012955ab603d520c74bf0f6d2761003262267a59546d6adaff7e2a54d4202b8c',
     armv7l: '012955ab603d520c74bf0f6d2761003262267a59546d6adaff7e2a54d4202b8c',
       i686: '160dd00e2155870635a429bc357e2501475f1e11a5606279708a6d760224e9ff',
     x86_64: '0edcd103db1895d1b599f4eed350541c40ab742b846ea4e6935987e8c296ea49',
  })

  depends_on 'gnutls'
  depends_on 'libpsl'
  depends_on 'libxdmcp'
  depends_on 'libmetalink'
  depends_on 'pcre2'

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
