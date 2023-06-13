require 'package'

class Mandb < Package
  description 'mandb is used to initialize or manually update index database caches that are usually maintained by man.'
  homepage 'https://man-db.nongnu.org/'
  version '2.11.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/man-db/man-db-2.11.2.tar.xz'
  source_sha256 'cffa1ee4e974be78646c46508e6dd2f37e7c589aaab2938cc1064f058fef9f8d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.2_armv7l/mandb-2.11.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.2_armv7l/mandb-2.11.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.2_i686/mandb-2.11.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.2_x86_64/mandb-2.11.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7ca41b1a29069b8c507e9905d7abf1e42362c2020733c560e4be5f67116b4c80',
     armv7l: '7ca41b1a29069b8c507e9905d7abf1e42362c2020733c560e4be5f67116b4c80',
       i686: '14996685ba4e52f79f1fa351362b9fa22033f85a15a7b71a461042ce34fe8b4f',
     x86_64: 'cd7f9d5d6e668baeeb8cc50be591895d29e0df43c7098b75b0f1da84504ae24a'
  })

  no_fhs

  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'groff'
  depends_on 'libpipeline' # R
  depends_on 'libseccomp' # R
  depends_on 'zlibpkg' # R

  def self.patch
    system "for f in $(grep -lr '/usr/local' | xargs); do sed -i 's,/usr/local,#{CREW_PREFIX},g' $f; done"
    system "for f in $(grep -lr '/usr/man' | xargs); do sed -i 's,/usr/man,#{CREW_PREFIX}/share/man,g' $f; done"
    system "for f in $(grep -lr '/usr/share/man' | xargs); do sed -i 's,/usr/share/man,#{CREW_PREFIX}/share/man,g' $f; done"
    system "for f in $(grep -lr '/var/cache/man' | xargs); do sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' $f; done"
  end

  def self.build
    # we can't write to /usr/lib/tmpfiles.d
    # we can't create the user 'man'
    # the pager is not at the default location
    system "./configure #{CREW_OPTIONS} \
      --disable-cache-owner \
      --disable-rpath \
      --disable-setuid \
      --enable-automatic-create \
      --enable-static \
      --with-bzip2=bzip2 \
      --with-compress=compress \
      --with-lzip=lzip \
      --with-lzma=lzma \
      --without-libiconv-prefix \
      --with-systemdtmpfilesdir=#{CREW_PREFIX}/etc/tmpfiles.d \
      --with-xz=xz \
      --with-zstd=zstd"
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/cache/man"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts 'Started mandb cache rebuild. (Errors from this can either be ignored or reported upstream to the relevant package maintainers.)'.yellow
    # See https://gitlab.com/man-db/man-db/-/issues/4
    # Also https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1003089
    system "MANPATH='' MAN_DISABLE_SECCOMP=1 mandb -C #{CREW_PREFIX}/etc/man_db.conf -psc"
    puts 'Finished mandb cache rebuild.'.lightgreen
  end
end
