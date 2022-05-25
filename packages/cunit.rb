require 'package'

class Cunit < Package
  description 'CUnit is an automated testing framework for C.'
  homepage 'http://cunit.sourceforge.net/'
  version '2.1.3'
  compatibility 'all'
  license 'LGPL-2'
  source_url 'https://sourceforge.net/projects/cunit/files/CUnit/2.1-3/CUnit-2.1-3.tar.bz2'
  source_sha256 'f5b29137f845bb08b77ec60584fdb728b4e58f1023e6f249a464efa49a40f214'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cunit/2.1.3_armv7l/cunit-2.1.3-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cunit/2.1.3_armv7l/cunit-2.1.3-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cunit/2.1.3_i686/cunit-2.1.3-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cunit/2.1.3_x86_64/cunit-2.1.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a956ac4488a0feeecc39cc924988975f91bac8358416ede01ec04dc8434a1a73',
      armv7l: 'a956ac4488a0feeecc39cc924988975f91bac8358416ede01ec04dc8434a1a73',
        i686: '24a8b62e060bbb03a52780db935d047f866234aca5b41b005f9ebfa872eaf58a',
      x86_64: 'a1577ab40f3522ac9a998f0041698856961e274796d27bd8fcc3ebd866a4943f'
  })

  def self.patch
    downloader 'https://httpredir.debian.org/debian/pool/main/c/cunit/cunit_2.1-3-dfsg-2.4.debian.tar.xz', 'e7a09a24c7db0e2aa9feb444fe38957286ebfc63b355c308957794f064b5881d'

    system 'tar xf cunit_2.1-3-dfsg-2.4.debian.tar.xz'

    File.foreach 'debian/patches/series' do |patch|
      system "patch -Np1 -i debian/patches/#{patch}"
    end

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
