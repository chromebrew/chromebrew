require 'package'

class Fakeroot < Package
  description 'Run a command in an environment faking root privileges for file manipulation.'
  homepage 'https://wiki.debian.org/FakeRoot'
  version '1.23'
  compatibility 'all'
  source_url 'http://ftp.debian.org/debian/pool/main/f/fakeroot/fakeroot_1.23.orig.tar.xz'
  source_sha256 '009cd6696a931562cf1c212bb57ca441a4a2d45cd32c3190a35c7ae98506f4f6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fakeroot-1.23-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fakeroot-1.23-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fakeroot-1.23-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fakeroot-1.23-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2ed598167ed99897379481674aee1637a41197747518eee2f4c062852066b5e8',
     armv7l: '2ed598167ed99897379481674aee1637a41197747518eee2f4c062852066b5e8',
       i686: '0295d42fdb5703320ccd2d329092b9a62133e6da160fa7880f11a8f46a635fd0',
     x86_64: '8d7f3cb9052e264d43aa8c37eda7b7da2e3710f7f29061ada7fbca6c90b1f814',
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
