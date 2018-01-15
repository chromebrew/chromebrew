require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.41'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/pango/1.41/pango-1.41.0.tar.xz'
  source_sha256 '1f76ef95953dc58ee5d6a53e5f1cb6db913f3e0eb489713ee9266695cae580ba'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'diffutils' => :build
  depends_on 'harfbuzz'
  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'perl'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
