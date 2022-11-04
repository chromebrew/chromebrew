require 'package'

class Mandb < Package
  description 'mandb is used to initialize or manually update index database caches that are usually maintained by man.'
  homepage 'https://man-db.nongnu.org/'
  @_ver = '2.11.0'
  version "#{@_ver}-1"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://download.savannah.gnu.org/releases/man-db/man-db-#{@_ver}.tar.xz"
  source_sha256 '4130e1a6241280359ef5e25daec685533c0a1930674916202ab0579e5a232c51'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.0-1_armv7l/mandb-2.11.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.0-1_armv7l/mandb-2.11.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.0-1_i686/mandb-2.11.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.0-1_x86_64/mandb-2.11.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'be4b1bebf8de1b0350a3e2d0cb4354e1c8450276eac6bcd14944ca6740643c71',
     armv7l: 'be4b1bebf8de1b0350a3e2d0cb4354e1c8450276eac6bcd14944ca6740643c71',
       i686: '9c95b0112d52452714f0668dc4097a0976fad38580634069d423550b00455e6f',
     x86_64: 'a1fc68aade500a3d4945912c91f9a01882cb1ffc23c3f4b1741725f25b2c4540'
  })

  no_fhs

  depends_on 'gdbm'
  depends_on 'glibc'
  depends_on 'groff'
  depends_on 'libpipeline'
  depends_on 'libseccomp'
  depends_on 'zlibpkg'

  def self.patch
    system "for f in $(grep -lr '/usr/local' | xargs); do sed -i 's,/usr/local,#{CREW_PREFIX},g' $f; done"
    system "for f in $(grep -lr '/usr/man' | xargs); do sed -i 's,/usr/man,#{CREW_PREFIX}/share/man,g' $f; done"
    system "for f in $(grep -lr '/usr/share/man' | xargs); do sed -i 's,/usr/share/man,#{CREW_PREFIX}/share/man,g' $f; done"
    system "for f in $(grep -lr '/var/cache/man' | xargs); do sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' $f; done"
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
