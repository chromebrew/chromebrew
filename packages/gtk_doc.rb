require 'package'

class Gtk_doc < Package
  description 'GTK-Doc is a project which was started to generate API documentation from comments added to C code.'
  homepage 'https://www.gtk.org/gtk-doc'
  version '1.29'
  compatibility 'all'
  source_url 'https://github.com/GNOME/gtk-doc/archive/GTK_DOC_1_29.tar.gz'
  source_sha256 'fdf5051e1f164fc1454a4530d217ee2c09dcc2c8e42b93cd5d68645493319ce5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_doc-1.29-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_doc-1.29-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_doc-1.29-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk_doc-1.29-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8641b7d74ba0de51e40347751c5022164f490703fcab9902d85843a3c6a8df41',
     armv7l: '8641b7d74ba0de51e40347751c5022164f490703fcab9902d85843a3c6a8df41',
       i686: '6c14eadd88bb454b2bdd1212935095d6fe478e932bc6bab301d519e767217c2f',
     x86_64: '53adc04a62779005099e257fc2ba6df76c0b8a9dce8cc31bd6eac6f4181b69c4',
  })

  depends_on 'six'
  depends_on 'libxslt'

  def self.build
    system './autogen.sh',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-xml-catalog=#{CREW_PREFIX}/etc/xml/catalog"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
