require 'package'

class Gtkmm3 < Package
  description 'The Gtkmm3 package provides a C++ interface to GTK+ 3.'
  homepage 'https://www.gtkmm.org/'
  version '3.22.2'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gtkmm/3.22/gtkmm-3.22.2.tar.xz'
  source_sha256 '91afd98a31519536f5f397c2d79696e3d53143b80b75778521ca7b48cb280090'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm3-3.22.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm3-3.22.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm3-3.22.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm3-3.22.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '01538cda99b9b67168aa6d723a06b80d8ebd4bf0bc3b218f793f70868ee2a8da',
     armv7l: '01538cda99b9b67168aa6d723a06b80d8ebd4bf0bc3b218f793f70868ee2a8da',
       i686: '3a89b7fd9f1b2c7bd863070144d3d84d0e99797eac3f8dfd06f7e88441ea0541',
     x86_64: '53bab1cbca694187e64084186991068557f6126064a0ca21f96508d55c9fba88',
  })

  depends_on 'atkmm'
  depends_on 'gtk3'
  depends_on 'pangomm'

  def self.build
    # fix the documents directory name
    system "sed -e '/^libdocdir =/ s/$(book_name)/gtkmm-3.22.2/' \
    -i docs/Makefile.in"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
 end

end
