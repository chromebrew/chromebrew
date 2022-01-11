require 'package'

class Cunit < Package
  description 'CUnit is an automated testing framework for C.'
  homepage 'http://cunit.sourceforge.net/'
  @_ver = '2.1.3'
  version @_ver
  license 'LGPL-2'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/cunit/files/CUnit/2.1-3/CUnit-2.1-3.tar.bz2'
  source_sha256 'f5b29137f845bb08b77ec60584fdb728b4e58f1023e6f249a464efa49a40f214'

  def self.patch
    downloader 'https://httpredir.debian.org/debian/pool/main/c/cunit/cunit_2.1-3-dfsg-2.4.debian.tar.xz'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('cunit_2.1-3-dfsg-2.4.debian.tar.xz') ) == 'e7a09a24c7db0e2aa9feb444fe38957286ebfc63b355c308957794f064b5881d'
    system 'tar xf cunit_2.1-3-dfsg-2.4.debian.tar.xz'
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\${i}; done"
    system "sed -i 's:<curses.h>:<ncursesw/curses.h>:' CUnit/Sources/Curses/Curses.c"
    system "sed -i 's:ncurses:ncursesw:g' configure.in"
  end

  def self.build
    system 'autoupdate'
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --enable-automated \
            --enable-basic \
            --enable-console \
            --enable-curses"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc", "#{CREW_DEST_PREFIX}/share/doc"
  end

  def self.check
    system 'make', 'check'
  end
end
