require 'package'

class Mandb < Package
  description 'mandb is used to initialize or manually update index database caches that are usually maintained by man.'
  homepage 'https://man-db.nongnu.org/'
  @_ver = '2.11.1'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url "https://download.savannah.gnu.org/releases/man-db/man-db-#{@_ver}.tar.xz"
  source_sha256 '2eabaa5251349847de9c9e43c634d986cbcc6f87642d1d9cb8608ec18487b6cc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.1_armv7l/mandb-2.11.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.1_armv7l/mandb-2.11.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.1_i686/mandb-2.11.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandb/2.11.1_x86_64/mandb-2.11.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7b2a35f0f53fd7a6c39106dde9e9dec1979c3c8c0e89feb827e05d14f9cd01d0',
     armv7l: '7b2a35f0f53fd7a6c39106dde9e9dec1979c3c8c0e89feb827e05d14f9cd01d0',
       i686: 'e00a108075955e9d82d4e59d48e263e1dc1758fef2d589e35953de86d1b4b0f6',
     x86_64: 'a5ea2cfbb94675f5216f07c7f2e558513c7536a8b15ea23ff7ac50014e65d77d'
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
    puts 'Creating mandb cache...'
    system "unset MANPATH && mandb -C #{CREW_PREFIX}/etc/man_db.conf -psc --quiet"
  end
end
