require 'package'

class Gnome_docking_library < Package
  description 'GUsb is a GObject wrapper for libusb1'
  homepage 'https://www.gnome.org/'
  version '3.28.0'
  source_url 'https://github.com/GNOME/gdl/archive/GDL_3_28_0.tar.gz'
  source_sha256 '14e4691026eb459ce1f65addce706eed1b2f61ef48fd6e59d72509337e87d14b'

  depends_on 'gtk_doc'
  depends_on 'gtk3'
  depends_on 'libxml2'

  def self.build
    system "./autogen.sh --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
