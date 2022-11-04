require 'package'

class Mandb < Package
  description 'mandb is used to initialize or manually update index database caches that are usually maintained by man.'
  homepage 'https://man-db.nongnu.org/'
  @_ver = '2.11.0'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url "https://download.savannah.gnu.org/releases/man-db/man-db-#{@_ver}.tar.xz"
  source_sha256 '4130e1a6241280359ef5e25daec685533c0a1930674916202ab0579e5a232c51'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.0_armv7l/mandb-2.11.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.0_armv7l/mandb-2.11.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.0_i686/mandb-2.11.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.0_x86_64/mandb-2.11.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c3753c2d92fe44b7c3bd087bbad23a421ba8973c0608cbe0ad4c7a63e1524dbb',
     armv7l: 'c3753c2d92fe44b7c3bd087bbad23a421ba8973c0608cbe0ad4c7a63e1524dbb',
       i686: '414c28db43fb301c2e5c64b57cd9ad45bbf1d1bd060f34766ba3b080051e511b',
     x86_64: '024fbf2cdfa243ee5ea95130f651938248d664868817a28321c4fce5ce278c7b'
  })

  no_fhs

  depends_on 'gdbm'
  depends_on 'glibc'
  depends_on 'groff'
  depends_on 'libpipeline'
  depends_on 'libseccomp'
  depends_on 'zlibpkg'

  def self.patch
    # Get file list with `grep -lr "/usr/man"` and exclude .md and changelog files.
    [
      'src/man_db.conf.in',
      'src/ult_src.c',
      'src/check_mandirs.c',
      'src/manp.c',
      'manual/files.me',
      'docs/manpage.example.mdoc',
      'docs/manpage.example.sgml',
      'docs/manpage.example.pod',
      'docs/manpage.example',
      'man/man8/mandb.man8',
      'man/man8/catman.man8',
      'man/man5/manpath.man5',
      'man/it/man8/mandb.man8',
      'man/it/man8/catman.man8',
      'man/it/man5/manpath.man5',
      'man/it/man1/whatis.man1',
      'man/man1/whatis.man1',
      'man/po4a/po/es.po',
      'man/po4a/po/de.po',
      'man/po4a/po/ja.po',
      'man/po4a/po/fr.po',
      'man/po4a/po/ru.po',
      'man/po4a/po/zh_CN.po',
      'man/po4a/po/pt_BR.po',
      'man/po4a/po/tr.po',
      'man/po4a/po/ro.po',
      'man/po4a/po/da.po',
      'man/po4a/po/sr.po',
      'man/po4a/po/sv.po',
      'man/po4a/po/pl.po',
      'man/po4a/po/pt.po',
      'man/po4a/po/nl.po',
      'man/po4a/po/id.po',
      'man/po4a/po/man-db-manpages.pot',
      'lib/compression.c',
      'tools/chconfig',
      'tools/checkman'
    ].each do |file|
      system "sed -i 's,/usr/man,#{CREW_PREFIX}/share/man,g' #{file}"
    end
    # Get file list with `grep -lr "/var/cache/man"` and exclude .md and changelog files.
    [
      'src/man_db.conf.in',
      'src/manp.c',
      'src/tests/mandb-cachedir-tag',
      'init/systemd/man-db.conf.in',
      'init/systemd/man-db.service.in',
      'include/manconfig.h',
      'manual/files.me',
      'manual/db.me',
      'man/man8/mandb.man8',
      'man/man8/accessdb.man8',
      'man/it/man8/accessdb.man8',
      'man/it/man1/apropos.man1',
      'man/it/man1/man.man1',
      'man/it/man1/whatis.man1',
      'man/man1/apropos.man1',
      'man/man1/whatis.man1',
      'man/po4a/po/fr.po',
      'man/po4a/po/ro.po',
      'man/po4a/po/da.po',
      'man/po4a/po/sr.po',
      'man/po4a/po/sv.po',
      'man/po4a/po/pl.po',
      'man/po4a/po/pt.po',
      'man/po4a/po/id.po',
      'man/po4a/po/man-db-manpages.pot',
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
    system "./configure #{CREW_OPTIONS} \
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
