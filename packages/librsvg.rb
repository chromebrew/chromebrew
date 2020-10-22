require 'package'

class Librsvg < Package
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version '2.50.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/librsvg/2.50/librsvg-2.50.1.tar.xz'
  source_sha256 '9bd9799322e06cf5db19b9f7afb728edac6efcf0110baafc44f0f96f45df9a09'

  depends_on 'cairo'
  depends_on 'gobject_introspection'
  depends_on 'freetype'
  depends_on 'gdk_pixbuf'
  depends_on 'libcroco'
  depends_on 'pango'
  depends_on 'rust' => :build
  depends_on 'glib'
  depends_on 'vala' => :build
  depends_on 'six' => :build
  
  def self.build
  # Following rustup modification as per 
  # https://github.com/rust-lang/rustup/issues/1167#issuecomment-367061388
    system "rustup install stable --profile minimal || (rm -frv ~/.rustup/toolchains/* && rustup install stable --profile minimal)"
    system "rustup default stable"
    system "./configure",
      #{CREW_OPTIONS},
      "--enable-introspection=yes",
      "--enable-vala=yes",
      "--disable-static",
      "--enable-pixbuf-loader",
      "--disable-tools"
      system 'make'
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
