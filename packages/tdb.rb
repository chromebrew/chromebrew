require 'package'

class Tdb < Package
  description 'tdb is a simple database API for sharing structures between parts of Samba'
  homepage 'https://tdb.samba.org/'
  version '1.4.3'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/tdb/tdb-#{version}.tar.gz"
  source_sha256 'c8058393dfa15f47e11ebd2f1d132693f0b3b3b8bf22d0201bfb305026f88a1b'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/tdb-1.4.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/tdb-1.4.3-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/tdb-1.4.3-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/tdb-1.4.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '658452e796dffb16b9cc074f47bee90e5155cca0888f444cb13b716b577c5e60',
     armv7l: '658452e796dffb16b9cc074f47bee90e5155cca0888f444cb13b716b577c5e60',
       i686: '22c959f77a28a1b13d2603557b4d87b454dd04099682ba7a749ad99b7a945a43',
     x86_64: '0040f43e9214ce035ca1eefca7923fce12aa8bc8710de383ca142c0eaaf12a9e'
  })

  depends_on 'docbook_xsl'
  depends_on 'libbsd'
  depends_on 'libxslt'

  def self.build
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS.sub(/--program-suffix.*/, '')}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
