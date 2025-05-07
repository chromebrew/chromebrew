require 'package'

class Man_db < Package
  description 'mandb is used to initialize or manually update index database caches that are usually maintained by man.'
  homepage 'https://man-db.nongnu.org/'
  version '2.13.1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://download.savannah.gnu.org/releases/man-db/man-db-#{version}.tar.xz"
  source_sha256 '82f0739f4f61aab5eb937d234de3b014e777b5538a28cbd31433c45ae09aefb9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '69d82acf43abd8c86610fb521e15ff2195416d94fca05f1406670a7a57d88c8f',
     armv7l: '69d82acf43abd8c86610fb521e15ff2195416d94fca05f1406670a7a57d88c8f',
       i686: '886df1ceeb9027a1f2f15324d1b7c1e526edc4cb117f74a844ab81d1c854b8d3',
     x86_64: '42825f7c458ec4ee088568635a3072efe45a13c860bf5b1e0b8a8f800dfb08bf'
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
