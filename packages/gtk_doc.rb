require 'package'

class Gtk_doc < Package
  description 'GTK-Doc is a project which was started to generate API documentation from comments added to C code.'
  homepage 'https://www.gtk.org/gtk-doc'
  version '1.26'
  source_url 'https://github.com/GNOME/gtk-doc/archive/GTK_DOC_1_26.tar.gz'
  source_sha256 'f0bcb1ff8268136fdbf426d7862f4f092e70b24a73632cfe0a3d31ed0d924b5c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_doc-1.26-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_doc-1.26-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_doc-1.26-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_doc-1.26-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0341eb6a16c9e6198a72bb2d5f091d3b4f45aa0a0237d92e2ba706736805f9b0',
     armv7l: '0341eb6a16c9e6198a72bb2d5f091d3b4f45aa0a0237d92e2ba706736805f9b0',
       i686: '867b201b1456d42848e209c7896c6651fc7bcbc84b42ea3e885a4559c27fdc49',
     x86_64: '03b2df2209431070c71579a0446f68f900e2b435b2d1f47c895128dd4a5cf501',
  })

  depends_on 'python3'
  depends_on 'python27'
  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'libxml2'
  depends_on 'libxslt'
  depends_on 'docbook'
  depends_on 'docbook_xml'
  depends_on 'docbook_xsl'

  def self.build
    system 'pip3 install six'
    system 'pip install six'
    system './autogen.sh --with-xml-catalog=/usr/local/etc/xml/catalog'
    system './configure --with-xml-catalog=/usr/local/etc/xml/catalog'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
