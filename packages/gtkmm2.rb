require 'package'

class Gtkmm2 < Package
  description 'The Gtkmm2 package provides a C++ interface to GTK+ 2.'
  homepage 'https://www.gtkmm.org/'
  version '2.24.5'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gtkmm/2.24/gtkmm-2.24.5.tar.xz'
  source_sha256 '0680a53b7bf90b4e4bf444d1d89e6df41c777e0bacc96e9c09fc4dd2f5fe6b72'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm2-2.24.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm2-2.24.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm2-2.24.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm2-2.24.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dac13fa160bade1d77733cc368cc55a901285d2901bc5a0e58e667cc9e5158d1',
     armv7l: 'dac13fa160bade1d77733cc368cc55a901285d2901bc5a0e58e667cc9e5158d1',
       i686: '7c677038f2b4d045ce6457bb960a1d8e09cd32f20e58018d64a446900f21c6dd',
     x86_64: 'ee4cb765b361813661d8be16a85f74ff60d5426cd34ac11eeecd2c4dadce3599',
  })

  depends_on 'atkmm'
  depends_on 'gtk2'
  depends_on 'pangomm'

  def self.build
    # fix the documents directory name
    system "sed -e '/^libdocdir =/ s/$(book_name)/gtkmm-2.24.5/' \
    -i docs/Makefile.in"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
 end

end
