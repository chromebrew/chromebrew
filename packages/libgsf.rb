require 'package'

class Libgsf < Package
  description 'The G Structured File Library'
  homepage 'https://gitlab.gnome.org/GNOME/libgsf'
  version '1.14.44'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/libgsf/1.14/libgsf-1.14.44.tar.xz'
  source_sha256 '68bede10037164764992970b4cb57cd6add6986a846d04657af9d5fac774ffde'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgsf-1.14.44-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgsf-1.14.44-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgsf-1.14.44-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgsf-1.14.44-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2ddd44b20669d3a473e11a3404533c18555c4b42d8809862a8cb0343c733606d',
     armv7l: '2ddd44b20669d3a473e11a3404533c18555c4b42d8809862a8cb0343c733606d',
       i686: '511a6260e66c54dd62eea8cb31bf372a746ac1d0757c718f76cd8553631ecb55',
     x86_64: 'd120538959fa7d352b23aeaf8d9eb637d73ba9c38c0002dfb495b7bf1b086589',
  })

  depends_on 'gdk_pixbuf'
  depends_on 'gtk_doc'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--enable-introspection'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
