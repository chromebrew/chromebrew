require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '1.19'
  source_url 'https://ftp.gnu.org/gnu/wget/wget-1.19.tar.xz'
  source_sha256 '0f1157bbf4daae19f3e1ddb70c6ccb2067feb834a6aa23c9d9daa7f048606384'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.19-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.19-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.19-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.19-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '306ce8e73db8c90fec3bacf29bcdcc904bc96bd9eb47fe760cebeb036c17d6fa',
     armv7l: '306ce8e73db8c90fec3bacf29bcdcc904bc96bd9eb47fe760cebeb036c17d6fa',
       i686: 'e13a781140e81610c6e56422e4ff8622d6f3ffb9422521adee08eb077dd90d62',
     x86_64: '572913991ca7d70a2eb643457c579b78b80b01bbf2fb9020fdc55fc29393ad3f',
  })

  depends_on 'buildessential' => :build
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
end
