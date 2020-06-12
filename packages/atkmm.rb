require 'package'

class Atkmm < Package
  description 'Atkmm is the official C++ interface for the ATK accessibility toolkit library.'
  homepage 'https://www.gtkmm.org/'
  version '2.24.2'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/atkmm/2.24/atkmm-2.24.2.tar.xz'
  source_sha256 'ff95385759e2af23828d4056356f25376cfabc41e690ac1df055371537e458bd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/atkmm-2.24.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/atkmm-2.24.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/atkmm-2.24.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/atkmm-2.24.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3b8bd296f91800c00124c56814bb255c53b75f120ee3fd0ee98384246836c8a4',
     armv7l: '3b8bd296f91800c00124c56814bb255c53b75f120ee3fd0ee98384246836c8a4',
       i686: 'e091b8ce4d5fce25477beff2b080fd874bdf79d22a1196f08058553a1667a8df',
     x86_64: '4b54089dfba9f62790935e2f8a2f7a953d8a8ff37158736167920747ce0d4675',
  })

  depends_on 'atk'
  depends_on 'glibmm'

  def self.build
    # fix the documents directory name
    system "sed -e '/^libdocdir =/ s/$(book_name)/atkmm-2.24.2/' \
    -i doc/Makefile.in"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
 end

end
