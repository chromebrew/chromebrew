require 'package'

class Mandb < Package
  description 'mandb is used to initialize or manually update index database caches that are usually maintained by man.'
  homepage 'https://man-db.nongnu.org/'
  @_ver = '2.11.1'
  version "#{@_ver}-1"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://download.savannah.gnu.org/releases/man-db/man-db-#{@_ver}.tar.xz"
  source_sha256 '2eabaa5251349847de9c9e43c634d986cbcc6f87642d1d9cb8608ec18487b6cc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.1-1_armv7l/mandb-2.11.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.1-1_armv7l/mandb-2.11.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.1-1_i686/mandb-2.11.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.1-1_x86_64/mandb-2.11.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7ffa35d04f002f98ad6e0e8348a17ff1835b8228cd0b40b26394cb6529febc12',
     armv7l: '7ffa35d04f002f98ad6e0e8348a17ff1835b8228cd0b40b26394cb6529febc12',
       i686: 'c78adc6559cbaab1133095413d24d215223e119d238bb2b5f9c78fee2a188c39',
     x86_64: '51fb382f653fcbfd7c5d57e78e02cb73115bd2f67751114a5faff811ba3e1fe4'
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
    puts 'Creating mandb cache. (Errors from this can either be ignored or reported upstream to the relevant package maintainers.)'
    system "unset MANPATH && mandb -C #{CREW_PREFIX}/etc/man_db.conf -psc"
  end
end
