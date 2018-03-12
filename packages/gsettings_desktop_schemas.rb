require 'package'

class Gsettings_desktop_schemas < Package
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://git.gnome.org/browse/gsettings-desktop-schemas'
  version '3.27.92'
  source_url 'https://github.com/GNOME/gsettings-desktop-schemas/archive/3.27.92.tar.gz'
  source_sha256 'f7605fe6d214dd64d6169541dabd630ed91f03ee23ca239d36667d616ca344c7'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'gobject_introspection'

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
