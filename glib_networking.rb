require 'package'

class Glib_networking < Package
  description 'Network-related giomodules for glib. https://git.gnome.org/browse/glib-networking/'
  homepage 'https://download.gnome.org/sources/glib-networking/'
  version '2.54.1'
  source_url 'https://download.gnome.org/sources/glib-networking/2.54/glib-networking-2.54.1.tar.xz'
  source_sha256 'eaa787b653015a0de31c928e9a17eb57b4ce23c8cf6f277afaec0d685335012f'

  depends_on 'gsettings_desktop_schemas'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
