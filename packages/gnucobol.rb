require 'package'

class Gnucobol < Package
  description 'GnuCOBOL (formerly OpenCOBOL) is a free COBOL compiler.'
  homepage 'https://www.gnu.org/software/gnucobol/'
  version '3.2'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/gnucobol/gnucobol-3.2.tar.xz'
  source_sha256 '3bb48af46ced4779facf41fdc2ee60e4ccb86eaa99d010b36685315df39c2ee2 '
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '414d959994a7816b3afca483ebbff70306ea9f5577e702957806f76f1d714718',
     armv7l: '414d959994a7816b3afca483ebbff70306ea9f5577e702957806f76f1d714718',
       i686: '5a881e05b716742c8f5e590f542a9b7eee411c38ff946e5896d843e21bb021ef',
     x86_64: '00e04366fab756136bba0bcb07a285c1bda4d218b5f6555e0bc67583fb051963'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libdb'
  depends_on 'ncurses' # R

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
