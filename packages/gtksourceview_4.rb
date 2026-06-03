require 'buildsystems/meson'

class Gtksourceview_4 < Meson
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  version '4.8.3-1'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gtksourceview.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff33f44e4d57b9c6730e677d65b51b26803ea33001efd5b4801e7b655da8af8f',
     armv7l: 'ff33f44e4d57b9c6730e677d65b51b26803ea33001efd5b4801e7b655da8af8f',
     x86_64: '5beb860777dded07813b99b8169208c27aae4b119dfee62b4d72173f733de515'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphene'
  depends_on 'gtk3' => :library
  depends_on 'gtk4'
  depends_on 'harfbuzz' => :library
  depends_on 'libsoup'
  depends_on 'libxml2' => :library
  depends_on 'pango' => :library
  depends_on 'vala'
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'zlib' => :library

  gnome
  no_upstream_update

  def self.patch
    system "sed -i 's/-fstack-protector-strong/-flto=auto/g' meson.build"
  end

  meson_options '-Db_asneeded=false'
end
