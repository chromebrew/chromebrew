require 'package'

class Libtool < Package
  description 'GNU libtool is a generic library support script. Libtool hides the complexity of using shared libraries behind a consistent, portable interface.'
  homepage 'https://www.gnu.org/software/libtool/'
  version '2.4.6-2'
  source_url 'https://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz'
  source_sha256 'e3bd4d5d3d025a36c21dd6af7ea818a2afcd4dfc1ea5a17b39d7854bcd0c06e3'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libtool-2.4.6-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libtool-2.4.6-2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libtool-2.4.6-2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libtool-2.4.6-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8c590c1a92eb3fba9a341a503c5cdd1bcc0bc505a261c43ce3a980aac94ad18d',
     armv7l: '8c590c1a92eb3fba9a341a503c5cdd1bcc0bc505a261c43ce3a980aac94ad18d',
       i686: 'ab153de8259f9eccd2ffbe3ef6eac2bad7d483d6338b064332abae11a3d00ac8',
     x86_64: 'aebbf436953ab2ed8d844ec2449216578243fda5145c5cdb12c257f388e863c2',
  })

  depends_on 'buildessential'
  depends_on 'm4'

  def self.build
    system "./configure", "--disable-static", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
