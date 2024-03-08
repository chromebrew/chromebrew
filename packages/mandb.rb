require 'package'

class Mandb < Package
  description 'mandb is used to initialize or manually update index database caches that are usually maintained by man.'
  homepage 'https://man-db.nongnu.org/'
  version '2.12.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/man-db/man-db-2.12.0.tar.xz'
  source_sha256 '415a6284a22764ad22ff0f66710d853be7790dd451cd71436e3d25c74d996a95'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a555f1b940b9404ac8116f01f247fe0f6740348e472912ce93353eb82541da3',
     armv7l: '0a555f1b940b9404ac8116f01f247fe0f6740348e472912ce93353eb82541da3',
       i686: 'a73a6859c6b32385258366403ecd1636275f25ff4fd20189ea9aa8d8142b607f',
     x86_64: '80d5f7e3547493821433c073ff03588e147cf2275f6cb7e8274980caf7c3c7a6'
  })

  no_fhs

  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'groff' # L
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
    year2038 = ARCH == 'x86_64' ? '' : ' --disable-year2038'
    options = CREW_OPTIONS + year2038
    system "./configure #{options} \
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
    puts "Starting backgrounded mandb cache rebuild. This will be logged to #{CREW_PREFIX}/var/log/man-db-rebuild.log.'.yellow
    puts '(Errors from this can either be ignored or reported upstream to the relevant package maintainers.)'.yellow
    # See https://gitlab.com/man-db/man-db/-/issues/4
    # Also https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1003089
    FileUtils.mkdir_p #{CREW_PREFIX}/var/log"
    system "MANPATH='' MAN_DISABLE_SECCOMP=1 nice -n 20 mandb -C #{CREW_PREFIX}/etc/man_db.conf -psc &> #{CREW_PREFIX}/var/log/man-db-rebuild.log &"
  end
end
