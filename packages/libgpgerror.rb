require 'package'

class Libgpgerror < Package
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.37'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.37.tar.bz2'
  source_sha256 'b32d6ff72a73cf79797f7f2d039e95e9c6f92f0c1450215410840ab62aea9763'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.37-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.37-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.37-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.37-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ca41263e0992f8e969a5f7b8818af433273f4c39f88cacad9d95a227c84b5d66',
     armv7l: 'ca41263e0992f8e969a5f7b8818af433273f4c39f88cacad9d95a227c84b5d66',
       i686: '27e1709a936bf87a1341da43712cad6834f2ba402e897c7d659411312e38a335',
     x86_64: '195afc96c0562686fcd14198c712f9fc77ee82d329046d914c1b754a6d04ca32',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
