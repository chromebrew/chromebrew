require 'package'

class Mandb < Package
  description 'mandb is used to initialize or manually update index database caches that are usually maintained by man.'
  homepage 'https://man-db.nongnu.org/'
  version '2.12.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/man-db/man-db-2.12.1.tar.xz'
  source_sha256 'ddee249daeb78cf92bab794ccd069cc8b575992265ea20e239e887156e880265'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '007b6aa82ac63e00c9f576b570cb40cc217c3817d50355de1f414a4db199878b',
     armv7l: '007b6aa82ac63e00c9f576b570cb40cc217c3817d50355de1f414a4db199878b',
       i686: '8b679dfe0a15583ccb3ef19377f8fb79b27aa8ae31d9e6bb5aaa9088cd3384c8',
     x86_64: 'e6e9d36cb3dcc908ee3f4574cda85aac6980428f2ac7e11954a4186355431a4a'
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
    puts "Starting backgrounded mandb cache rebuild. This will be logged to #{CREW_PREFIX}/var/log/man-db-rebuild.log.".yellow
    puts '(Errors from this can either be ignored or reported upstream to the relevant package maintainers.)'.yellow
    # See https://gitlab.com/man-db/man-db/-/issues/4
    # Also https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1003089
    FileUtils.mkdir_p "#{CREW_PREFIX}/var/log"
    system "MANPATH='' MAN_DISABLE_SECCOMP=1 nice -n 20 mandb -C #{CREW_PREFIX}/etc/man_db.conf -psc &> #{CREW_PREFIX}/var/log/man-db-rebuild.log &"
  end
end
