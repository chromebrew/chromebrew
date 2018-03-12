require 'package'

class Gdl < Package
  description 'GNU Data Language. http://gnudatalanguage.sourceforge.net/'
  homepage 'https://download.gnome.org/sources/gdl/'
  version '3.28.0'
  source_url 'https://download.gnome.org/sources/gdl/3.28/gdl-3.28.0.tar.xz'
  source_sha256 '52cc98ecc105148467b3b2b4e0d27ae484b1b6710d53413f771ed07ef1b737b6'

  depends_on 'ncurses'
  depends_on 'readline'
  depends_on 'libx11'
  depends_on 'gtk3'
  depends_on 'gnome_common'
  depends_on 'gobject_introspection'
  depends_on 'gtk_doc'

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
