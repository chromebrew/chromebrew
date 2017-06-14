require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  version '2.9.0'
  source_url 'http://download.qemu-project.org/qemu-2.9.0.tar.xz'
  source_sha1 '5cc63c6cababaaa7d0685e8b32bacf5022873ebc'

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
