require 'package'

class Gdk_pixbuf < Package
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://developer.gnome.org/gdk-pixbuf'
  version '2.36.7-1'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.36/gdk-pixbuf-2.36.7.tar.xz'
  source_sha256 '1b6e5eef09d98f05f383014ecd3503e25dfb03d7e5b5f5904e5a65b049a6a4d8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.36.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.36.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.36.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.36.7-1-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: '3baf4efbf49e731ae15e0f3650dccbf47e1128fc735b3f1dc0b82f49faaac926',
     armv7l: '3baf4efbf49e731ae15e0f3650dccbf47e1128fc735b3f1dc0b82f49faaac926',
       i686: 'b70469069a781d819aedb94f5c6e1a829815b76aef27926129d43bf20fe97042',
     x86_64: '044b281179d0d781757bd131fc181169e74bf3018f4de51fa8550449ea96f19e',

  })

  depends_on 'pango'
  depends_on 'gobject_introspection'
  depends_on 'libtiff'
  depends_on 'libjpeg'
  depends_on 'python27'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --with-x11"
    system "make"
  end

  def self.install
    system "pip install six" # for installation process
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0"
    system "touch #{CREW_DEST_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache"      
    system "pip uninstall --yes six"
  end
  
  def self.postinstall
    system "gdk-pixbuf-query-loaders --update-cache"
  end
end
