require 'package'

class Gexiv2 < Package
  description 'gexiv2 is a GObject wrapper around the Exiv2 photo metadata library.'
  homepage 'https://wiki.gnome.org/Projects/gexiv2/'
  version '0.14.0'
  license 'LGPL-2.1+ and GPL-2'
  compatibility 'all'
  source_url "https://download.gnome.org/sources/gexiv2/#{version.rpartition('.')[0]}/gexiv2-#{version}.tar.xz"
  source_sha256 'e58279a6ff20b6f64fa499615da5e9b57cf65ba7850b72fafdf17221a9d6d69e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25bf888e23ceedb54f8adfa3b87737e66ad03ef9e6fc6292bb5888ea443ad8f7',
     armv7l: '25bf888e23ceedb54f8adfa3b87737e66ad03ef9e6fc6292bb5888ea443ad8f7',
       i686: 'f30043519e9bfd162de74b32c1b788d7876eaf9a03b3dfdcd384fda40455ea84',
     x86_64: '1a1f1d403dd3f65e8d84001a8cefb35ec7ab42fcf1dc865181221d8dacaa3c76'
  })

  depends_on 'libexiv2'
  depends_on 'gobject_introspection'
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
