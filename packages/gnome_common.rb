require 'package'

class Gnome_common < Package
  description 'Common files for development of Gnome packages. https://git.gnome.org/browse/gnome-common'
  homepage 'https://github.com/GNOME/gnome-common/releases'
  version '3.18.0'
  source_url 'https://github.com/GNOME/gnome-common/archive/3.18.0.tar.gz'
  source_sha256 '8407fd8786a44c9ce47987de0906d9266492195df9251a089afaa06cc65c72d8'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
