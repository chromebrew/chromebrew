require 'package'

class Gdbm < Package
  description 'GNU dbm is a set of database routines that use extensible hashing.'
  homepage 'https://www.gnu.org/software/gdbm/'
  version '1.18'
  source_url 'https://ftpmirror.gnu.org/gdbm/gdbm-1.18.tar.gz'
  source_sha256 'b8822cb4769e2d759c828c06f196614936c88c141c3132b18252fe25c2b635ce'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdbm-1.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdbm-1.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdbm-1.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdbm-1.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a3b6c2d3440a27d1f3929d499e17cd5f789111f611ff4bf2b2308a2a81d1f792',
     armv7l: 'a3b6c2d3440a27d1f3929d499e17cd5f789111f611ff4bf2b2308a2a81d1f792',
       i686: '8883a3831231730231ddf8bf217e0fc2bff61386ef59bcf24dabd2c423a64d76',
     x86_64: 'f9a1eeed7bfbd803705df5314aaf4585df2e3eb04b1b22e80e254b836281518f',
  })

  depends_on 'readline'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static',
           '--enable-shared',
           '--with-pic'
    system 'make'
  end

  def self.check
    system "make check"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
