require 'package'

class Mandb < Package
  description 'mandb is used to initialize or manually update index database caches that are usually maintained by man.'
  homepage 'http://man-db.nongnu.org/'
  @_ver = '2.9.4'
  version @_ver
  compatibility 'all'
  source_url "https://download.savannah.gnu.org/releases/man-db/man-db-#{@_ver}.tar.xz"
  source_sha256 'b66c99edfad16ad928c889f87cf76380263c1609323c280b3a9e6963fdb16756'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.9.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.9.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.9.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.9.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ccd36d83dc2dcb04d003a79fd503273ebd06a77d4da618f7033d537fda537d4e',
     armv7l: 'ccd36d83dc2dcb04d003a79fd503273ebd06a77d4da618f7033d537fda537d4e',
       i686: '97a79a235a9ab3c3f077ddf462a79d9d17ff3ff6cd35145321d790253775387f',
     x86_64: '30939c206bd1adc66a33a8157d749b288a3726a995a8eb318c057104807c138d'
  })

  depends_on 'gdbm'
  depends_on 'groff'
  depends_on 'libpipeline'

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    # we can't write to /usr/lib/tmpfiles.d
    # we can't create the user 'man'
    # the pager is not at the default location
    system './configure --help'
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
      --with-pager=#{CREW_PREFIX}/bin/most"
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/cache/man"
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
    system "sed -i 's,/usr/share/man,#{CREW_PREFIX}/share/man,g' tools/chconfig"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "sed -i 's,/usr/share/man,#{CREW_PREFIX}/share/man,g' #{CREW_DEST_PREFIX}/etc/man_db.conf"
    system "sed -i 's,/usr/man,#{CREW_PREFIX}/share/man,g' #{CREW_DEST_PREFIX}/etc/man_db.conf"
  end

  def self.postinstall
    system "env MANPATH=#{CREW_MAN_PREFIX} mandb -psc"
    pager_in_bashrc = `grep -c "PAGER" ~/.bashrc || true`
    unless pager_in_bashrc.to_i.positive?
      puts 'Putting PAGER=most in ~/.bashrc'.lightblue
      system "echo 'export PAGER=most' >> ~/.bashrc"
      puts 'To complete the installation, execute the following:'.orange
      puts 'source ~/.bashrc'.orange
    end
  end
end
