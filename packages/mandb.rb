require 'package'

class Mandb < Package
  description 'mandb is used to initialize or manually update index database caches that are usually maintained by man.'
  homepage 'https://man-db.nongnu.org/'
  @_ver = '2.9.4'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url "https://download.savannah.gnu.org/releases/man-db/man-db-#{@_ver}.tar.xz"
  source_sha256 'b66c99edfad16ad928c889f87cf76380263c1609323c280b3a9e6963fdb16756'

  depends_on 'gdbm'
  depends_on 'groff'
  depends_on 'libpipeline'
  depends_on 'libseccomp'

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
      --disable-rpath \
      --with-pager=/usr/bin/more"
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
