require 'package'

class Atk < Package
  description 'GTK+ & GNOME Accessibility Toolkit. https://wiki.gnome.org/Accessibility'
  homepage 'https://download.gnome.org/sources/atk/'
  version '2.28.1'
  source_url 'https://download.gnome.org/sources/atk/2.28/atk-2.28.1.tar.xz'
  source_sha256 'cd3a1ea6ecc268a2497f0cd018e970860de24a6d42086919d6bf6c8e8d53f4fc'

  depends_on 'gobject_introspection'
  depends_on 'diffutils' => :build
  depends_on 'perl' => :build
  depends_on 'python27' => :build
  depends_on 'gtk_doc'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
