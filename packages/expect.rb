require 'package'

class Expect < Package
  description 'Expect is a tool for automating interactive applications such as telnet, ftp, passwd, fsck, rlogin, tip, etc.'
  homepage 'http://expect.sourceforge.net/'
  version '5.45-1'
  source_url 'http://prdownloads.sourceforge.net/expect/expect5.45.tar.gz'
  source_sha256 'b28dca90428a3b30e650525cdc16255d76bb6ccd65d448be53e620d95d5cc040'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/expect-5.45-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/expect-5.45-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/expect-5.45-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/expect-5.45-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9733154787b454ec4f49d115c2083a93364369dace1aea6a3db4d0116bbce700',
     armv7l: '9733154787b454ec4f49d115c2083a93364369dace1aea6a3db4d0116bbce700',
       i686: '93b62ea3fdcb0edf97d8eb3605ad33d23fc25cf04c5cc08e5c1adb5eeb878fed',
     x86_64: '870d06b53f44fc395923dcaa3c1abe3064d62d07c3fb2035c0b080a03dd820f5',
  })

  depends_on "tcl"

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make test"
  end
end
