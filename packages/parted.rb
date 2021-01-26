require 'package'

class Parted < Package
  description 'Create, destroy, resize, check, copy partitions and file systems.'
  homepage 'https://www.gnu.org/software/parted'
  @_ver = '3.3'
  version @_ver
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/parted/parted-#{@_ver}.tar.xz"
  source_sha256 '57e2b4bd87018625c515421d4524f6e3b55175b472302056391c5f7eccb83d44'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/parted-3.3-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/parted-3.3-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/parted-3.3-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/parted-3.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '98ed6e820c9c05fc359d47ff2eea255cb1b336f86db4b212c9382ca4c12ae580',
      armv7l: '98ed6e820c9c05fc359d47ff2eea255cb1b336f86db4b212c9382ca4c12ae580',
        i686: 'ce9523de48e30a28c75f0c5651eb17030f02c78e47d2fd700456f44e2566557f',
      x86_64: '7c80e009bb00704ddd43e79f18f1e1c9ade975590c1fa0d28fdedd8ebc679ef4',
  })

  depends_on 'lvm2'
  depends_on 'ncurses'
  depends_on 'readline'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
