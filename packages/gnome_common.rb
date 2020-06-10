require 'package'

class Gnome_common < Package
  description 'Common files for development of Gnome packages.'
  homepage 'https://git.gnome.org/browse/gnome-common'
  version '3.18.0'
  compatibility 'all'
  source_url 'https://github.com/GNOME/gnome-common/archive/3.18.0.tar.gz'
  source_sha256 '8407fd8786a44c9ce47987de0906d9266492195df9251a089afaa06cc65c72d8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_common-3.18.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_common-3.18.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_common-3.18.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_common-3.18.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5a3383100374ce40ddf230237ac656958fb7ec72cf2d0896a9101e3208f9a9bb',
     armv7l: '5a3383100374ce40ddf230237ac656958fb7ec72cf2d0896a9101e3208f9a9bb',
       i686: 'c979f4542bb8b87fb4883787005a1ccbec9e752829885cd5e3c66a385336a15c',
     x86_64: 'c04053bbe47296b90c22a3d5767d54645f819ef73ee362a60e1e179a8ce836cd',
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
