require 'package'

class Fakeroot < Package
  description 'Run a command in an environment faking root privileges for file manipulation.'
  homepage 'https://wiki.debian.org/FakeRoot'
  version '1.22'
  source_url 'http://ftp.debian.org/debian/pool/main/f/fakeroot/fakeroot_1.22.orig.tar.bz2'
  source_sha256 'bd806a4a1e641203eb3d4571a10089e8a038c10ec7e492fa1e061b03ae3ec6fe'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fakeroot-1.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fakeroot-1.22-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fakeroot-1.22-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fakeroot-1.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8dfcec632348bead691204abdf493dffac22a85b1819e2bdd638315f5c1f58a3',
     armv7l: '8dfcec632348bead691204abdf493dffac22a85b1819e2bdd638315f5c1f58a3',
       i686: '8f7910d6b62ede0eccdc13e372dd1c618cf0c041a7f897c123f660282708dcb2',
     x86_64: '5bb13065ae77f120008b36adab613cb9758d9ffd6cdc4604cb4ec55160b70390',
  })

  depends_on 'libcap' => :build
  
  def self.build
    system './bootstrap'
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
