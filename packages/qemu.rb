require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  version '2.9.0'
  source_url 'http://download.qemu-project.org/qemu-2.9.0.tar.xz'
  source_sha256 'f01cc33e3c5fd5fd2534ce14e369b6b111d7e54e4a4977f8c37eae668176b022'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6099a6d3e20aa1070dca482d8ba0d31e6cc7ac1369c30629fbc4b5ba877b607e',
     armv7l: '6099a6d3e20aa1070dca482d8ba0d31e6cc7ac1369c30629fbc4b5ba877b607e',
       i686: '473d524b2954ab1e562ccd29dd12f60020b943a8e70df44459a1e6ececa5f4dc',
     x86_64: 'fe5528d7c1e152afe6f97e7cca05889cc7fd3004f27fa87dc34eb5c85f46fe55',
  })

  depends_on 'glib'
  depends_on 'autoconf'
  depends_on 'gettext'
  depends_on 'automake'
  depends_on 'libtool'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
