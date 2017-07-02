require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  version '2.9.0'
  source_url 'http://download.qemu-project.org/qemu-2.9.0.tar.xz'
  source_sha256 'f01cc33e3c5fd5fd2534ce14e369b6b111d7e54e4a4977f8c37eae668176b022'

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
