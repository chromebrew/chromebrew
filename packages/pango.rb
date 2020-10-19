require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.47.0'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/pango/1.47/pango-1.47.0.tar.xz'
  source_sha256 '730db8652fc43188e03218c3374db9d152351f51fc7011b9acae6d0a6c92c367'



  depends_on 'harfbuzz'
  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'gobject_introspection'   # add this package to build gtk+, avoid compilation error
  depends_on 'libxrender'
  depends_on 'fribidi' # Gets built inside install automatically.
  depends_on 'six'
  depends_on 'llvm' => ':build'

  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "meson",
      "-Dprefix=#{CREW_PREFIX}",
      "-Dlibdir=#{CREW_LIB_PREFIX}",
      "-Dinstall-tests=false",
      "builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
