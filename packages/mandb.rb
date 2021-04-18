require 'package'

class Mandb < Package
  description 'mandb is used to initialize or manually update index database caches that are usually maintained by man.'
  homepage 'https://man-db.nongnu.org/'
  @_ver = '2.9.4'
  version "#{@_ver}-1"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://download.savannah.gnu.org/releases/man-db/man-db-#{@_ver}.tar.xz"
  source_sha256 'b66c99edfad16ad928c889f87cf76380263c1609323c280b3a9e6963fdb16756'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/mandb-2.9.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/mandb-2.9.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/mandb-2.9.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/mandb-2.9.4-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1380c9d892dee58035943cd45e0fbdde24076ecff95d217a244b23d29530fda2',
     armv7l: '1380c9d892dee58035943cd45e0fbdde24076ecff95d217a244b23d29530fda2',
       i686: '860f38f174b9843b2d83116ba3a56b3a8735f1a084b30b3edde385e852d91699',
     x86_64: 'cae256c6989d0654bd9c73bb84e2fd0a98f1497e1499cc2f48f928cdfbcf32fb'
  })

  depends_on 'gdbm'
  depends_on 'glibc'
  depends_on 'groff' => :build
  depends_on 'libpipeline'
  depends_on 'libseccomp'
  depends_on 'zlibpkg'

  def self.patch
    system "sed -i 's,/usr/man,#{CREW_PREFIX}/share/man,g' src/man_db.conf.in"
    [
      'src/man_db.conf.in',
      'tools/chconfig'
    ].each do |file|
      system "sed -i 's,/usr/share/man,#{CREW_PREFIX}/share/man,g' #{file}"
    end
    [
      'include/manconfig.h.in',
      'src/manp.c',
      'src/man_db.conf.in',
      'manual/db.me',
      'manual/files.me',
      'man/man1/whatis.man1',
      'man/man1/apropos.man1',
      'man/man1/man.man1',
      'man/man8/accessdb.man8',
      'man/man8/mandb.man8',
      'tools/chconfig'
    ].each do |file|
      system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' #{file}"
    end
  end

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    # we can't write to /usr/lib/tmpfiles.d
    # we can't create the user 'man'
    # the pager is not at the default location
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --with-systemdtmpfilesdir=#{CREW_PREFIX}/etc/tmpfiles.d \
      --disable-cache-owner \
      --disable-setuid \
      --enable-automatic-create \
      --enable-static \
      --without-libiconv-prefix \
      --disable-rpath"
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/cache/man"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system "env MANPATH=#{CREW_MAN_PREFIX} mandb -psc"
  end
end
