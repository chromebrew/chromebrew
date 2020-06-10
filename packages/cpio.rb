require 'package'

class Cpio < Package
  description 'GNU cpio copies files into or out of a cpio or tar archive. The archive can be another file on the disk, a magnetic tape, or a pipe.'
  homepage 'https://www.gnu.org/software/cpio/'
  version '2.12'
  compatibility 'all'
  source_url 'http://ftp.gnu.org/gnu/cpio/cpio-2.12.tar.gz'
  source_sha256 '08a35e92deb3c85d269a0059a27d4140a9667a6369459299d08c17f713a92e73'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cpio-2.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cpio-2.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cpio-2.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cpio-2.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ce329d2fa0fc9f708af6992a72335ed787e2c6753ed745149f3b343e5d237f0d',
     armv7l: 'ce329d2fa0fc9f708af6992a72335ed787e2c6753ed745149f3b343e5d237f0d',
       i686: '9240db94042983365a1c70b762dfee9870ee75697e13b88ae33b86b94d2a7d50',
     x86_64: '492cb4051825b4de2393229e82ace30f19cd43794f0828d76d0466e97c88916d',
  })

  depends_on 'binutils'
  depends_on 'gawk'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
