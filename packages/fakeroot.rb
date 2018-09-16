require 'package'

class Fakeroot < Package
  description 'Run a command in an environment faking root privileges for file manipulation.'
  homepage 'https://wiki.debian.org/FakeRoot'
  version '1.23'
  source_url 'http://ftp.debian.org/debian/pool/main/f/fakeroot/fakeroot_1.23.orig.tar.bz2'
  source_sha256 '009cd6696a931562cf1c212bb57ca441a4a2d45cd32c3190a35c7ae98506f4f6'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libcap'
  
  def self.build
    system './bootstrap'
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
