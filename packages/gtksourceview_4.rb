require 'package'

class Gtksourceview_4 < Package
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  version '4.8.3'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gtksourceview.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '664f99be9dcaf2caba948f7ff4f06b9b1280bc78b0c95608f3e8d2cdfab65edd',
     armv7l: '664f99be9dcaf2caba948f7ff4f06b9b1280bc78b0c95608f3e8d2cdfab65edd',
       i686: '02daf0ff8c5a8fa2b86fad1a1ad71dfeff43c5fc81467cedfa874f849737b6a5',
     x86_64: 'a9c2b5d14d3b1603ed0400edd45aa2ca907d1bdf413c85623152788ed342d494'
  })

  depends_on 'at_spi2_core'
  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'graphene'
  depends_on 'gtk3'
  depends_on 'gtk4'
  depends_on 'harfbuzz'
  depends_on 'libsoup'
  depends_on 'pango'
  depends_on 'vala'
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'zlibpkg' # R

  def self.patch
    system "sed -i 's/-fstack-protector-strong/-flto=auto/g' meson.build"
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Db_asneeded=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
