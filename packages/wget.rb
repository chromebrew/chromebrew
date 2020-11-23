require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '1.20.3-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/wget/wget-1.20.3.tar.lz'
  source_sha256 '69607ce8216c2d1126b7a872db594b3f21e511e660e07ca1f81be96650932abb'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gnutls'
  depends_on 'libpsl'
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
