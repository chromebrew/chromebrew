require 'package'

class Gtk2 < Package
  description 'Gtk+ 2.24 graphical user interface library.'
  homepage 'https://www.gtk.org/'
  version '2.24'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/gtk+-2.24.32.tar.xz'
  source_sha256 'b6c8a93ddda5eabe3bfee1eb39636c9a03d2a56c7b62828b359bf197943c582e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk2-2.24-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk2-2.24-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk2-2.24-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk2-2.24-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd3c7e104ceeb13827016447cfe6f3db5a5c3a8a50fc8be54f67e1893700bd388',
     armv7l: 'd3c7e104ceeb13827016447cfe6f3db5a5c3a8a50fc8be54f67e1893700bd388',
       i686: '9d961a6437d896cd1dbde21ebe4a20967ad0267621fbbb7d80cb36309fd7f232',
     x86_64: '96e236c0057e01ac2790ec5881349a2fa4b6c0821fa3d9ae477a1471f0c1d1af',
  })
  
  depends_on 'docbook_xml'
  depends_on 'docbook_xsl'
  depends_on 'gtk_doc'
  depends_on 'atk'
  depends_on 'pango'
  depends_on 'cairo'
  depends_on 'gdk_pixbuf'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "pip install six"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
    system "pip uninstall --yes six"
  end
  
end
