require 'package'

class Gusb < Package
  description 'GUsb is a GObject wrapper for libusb1'
  homepage 'https://www.openhub.net/p/gusb'
  version '0.2.11-0'
  compatibility 'all'
  source_url 'https://github.com/hughsie/libgusb/archive/gusb_0_2_11.tar.gz'
  source_sha256 '090eb605e75f8a5b0b3df7ff29d96dd51730850ac89417378d4a8d39fab13702'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gusb-0.2.11-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gusb-0.2.11-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gusb-0.2.11-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gusb-0.2.11-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7c75eff68455aad38547deac7a50f44992bc47dc8a72ec12e5038f72783266cb',
     armv7l: '7c75eff68455aad38547deac7a50f44992bc47dc8a72ec12e5038f72783266cb',
       i686: '84a56516c6b57823eb7f921c96e7de2989b6fc6b0fbd2777b15510059cc8f04f',
     x86_64: 'fa9af05a8ab68391a7221b5b3b6feb986b66c40f1bbebde98bf1a1c4fd9089bd',
  })

  depends_on 'gtk_doc'
  depends_on 'libusb'
  depends_on 'gobject_introspection'

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
