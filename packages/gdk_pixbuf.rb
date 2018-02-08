require 'package'

class Gdk_pixbuf < Package
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://developer.gnome.org/gdk-pixbuf'
  version '2.36.7'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.36/gdk-pixbuf-2.36.7.tar.xz'
  source_sha256 '1b6e5eef09d98f05f383014ecd3503e25dfb03d7e5b5f5904e5a65b049a6a4d8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.36.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.36.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.36.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.36.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5e1b4efd43d724cbf2a525e193cb104ec09f45007c8d99cd0c113060013d5d36',
     armv7l: '5e1b4efd43d724cbf2a525e193cb104ec09f45007c8d99cd0c113060013d5d36',
       i686: 'f51aece1494cdf21d63c609dc5be2055acb8afd5051ed7b149c286fc06e95a56',
     x86_64: '7eab51523a55ebfcd8d87edf83554efbf04078eb8cfeafc1bb269081ce01f426',
  })

  depends_on 'pango'
  depends_on 'gobject_introspection'
  depends_on 'libtiff'
  depends_on 'libjpeg'
  depends_on 'python27'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "pip install six" # for installation process
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "pip uninstall --yes six"
  end
end
