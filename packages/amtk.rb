require 'package'

class Amtk < Package
  description 'Actions, Menus and Toolbars Kit for GTK+ applications'
  homepage 'https://wiki.gnome.org/Projects/Amtk'
  version '5.2.0-33ec'
  compatibility 'all'
  source_url 'https://github.com/GNOME/amtk/archive/33ec171156ebc49d6dad568e6ba39470edb272e1.zip'
  source_sha256 'fc9bad18bbd5421da52e0548f9e91eda180539bb568d1e7116ca65f4f73f4b67'

  depends_on 'gtk3'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'llvm' => :build

  ENV['CC'] = 'clang'
  ENV['CXX'] = 'clang'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
