require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '1.19'
  source_url 'https://ftp.gnu.org/gnu/wget/wget-1.19.tar.xz'
  source_sha256 '0f1157bbf4daae19f3e1ddb70c6ccb2067feb834a6aa23c9d9daa7f048606384'

  binary_url ({
  })
  binary_sha256 ({
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
