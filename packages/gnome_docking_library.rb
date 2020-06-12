require 'package'

class Gnome_docking_library < Package
  description 'GUsb is a GObject wrapper for libusb1'
  homepage 'https://www.gnome.org/'
  version '3.28.0-0'
  compatibility 'all'
  source_url 'https://github.com/GNOME/gdl/archive/GDL_3_28_0.tar.gz'
  source_sha256 '14e4691026eb459ce1f65addce706eed1b2f61ef48fd6e59d72509337e87d14b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_docking_library-3.28.0-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_docking_library-3.28.0-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_docking_library-3.28.0-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_docking_library-3.28.0-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '666e943121c47a202f5de8800c00226b917dbbbe75d0ba8b9dacba68f0f9ad41',
     armv7l: '666e943121c47a202f5de8800c00226b917dbbbe75d0ba8b9dacba68f0f9ad41',
       i686: 'e6156b06ba347cd9c956554194bad924edc558e6385191b1e8d867eb8cf8a959',
     x86_64: '94341d3b3ea28e34a48e0610996901a9c1905f98b7fa0063c0f4938b27c337ed',
  })

  depends_on 'gtk_doc'
  depends_on 'gtk3'
  depends_on 'libxml2'
  depends_on 'gnome_common'

  def self.build
    system "./autogen.sh --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
