require 'buildsystems/meson'

class Gtksourceview_5 < Meson
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  version '5.6.1'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gtksourceview.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f8d59796235811fe0293bc1b812a4bb65a717c4ba05a6accd7cd850d1b55208',
     armv7l: '0f8d59796235811fe0293bc1b812a4bb65a717c4ba05a6accd7cd850d1b55208',
     x86_64: '025bfd8d5b98858324e8590e0f3fb813b5f7464e63bfe2e346f9925fe153ef69'
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
  depends_on 'pcre2' # R

  gnome

  def self.patch
    system "sed -i 's/-fstack-protector-strong/-flto=auto/g' meson.build"
  end

  meson_options '-Db_asneeded=false'
end
