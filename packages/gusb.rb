require 'package'

class Gusb < Package
  description 'GUsb is a GObject wrapper for libusb1'
  homepage 'https://www.openhub.net/p/gusb'
  version '0.2.11'
  source_url 'https://github.com/hughsie/libgusb/archive/gusb_0_2_11.tar.gz'
  source_sha256 '090eb605e75f8a5b0b3df7ff29d96dd51730850ac89417378d4a8d39fab13702'

  depends_on 'automake' => :build
  depends_on 'glib'
  depends_on 'gtk_doc'
  depends_on 'libusb'
  depends_on 'libtool' => :build
  depends_on 'intltool' => :build

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
