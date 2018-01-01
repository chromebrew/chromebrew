require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '1.19.2'
  source_url 'https://ftp.gnu.org/gnu/wget/wget-1.19.2.tar.gz'
  source_sha256 '4f4a673b6d466efa50fbfba796bd84a46ae24e370fa562ede5b21ab53c11a920'

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
