require 'package'

class Man_db < Package
  description 'mandb is used to initialize or manually update index database caches that are usually maintained by man.'
  homepage 'https://man-db.nongnu.org/'
  version '2.13.1-1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://download.savannah.gnu.org/releases/man-db/man-db-#{version.split('-').first}.tar.xz"
  source_sha256 '8afebb6f7eb6bb8542929458841f5c7e6f240e30c86358c1fbcefbea076c87d9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d8c03f527b17119cf23a942d368fddc9bcce9c11d776c51f9c2bba2e8b05fbf',
     armv7l: '2d8c03f527b17119cf23a942d368fddc9bcce9c11d776c51f9c2bba2e8b05fbf',
       i686: 'cc2ef77082615544e76fb42b91e256245a070f9b24339f5985ec15170f6986f6',
     x86_64: 'd9313d25e62824542752d3549879ffd241139a685151bed86cd6c51caf27d2f9'
  })

  no_fhs

  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'groff' # L
  depends_on 'libpipeline' # R
  depends_on 'libseccomp' # R
  depends_on 'zlib' # R

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
    options = CREW_CONFIGURE_OPTIONS + year2038
    system "./configure #{options} \
      --disable-cache-owner \
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
    puts "Starting backgrounded mandb cache rebuild. This will be logged to #{CREW_PREFIX}/var/log/man-db-rebuild.log.".yellow
    puts '(Errors from this can either be ignored or reported upstream to the relevant package maintainers.)'.yellow
    # See https://gitlab.com/man-db/man-db/-/issues/4
    # Also https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1003089
    FileUtils.mkdir_p "#{CREW_PREFIX}/var/log"
    system "MANPATH='' MAN_DISABLE_SECCOMP=1 nice -n 20 mandb -C #{CREW_PREFIX}/etc/man_db.conf -psc &> #{CREW_PREFIX}/var/log/man-db-rebuild.log &"
  end
end
