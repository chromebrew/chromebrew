require 'buildsystems/meson'

class Gtksourceview_5 < Meson
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  version '5.18.0'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gtksourceview.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc41489cf90b691c2ad84c4ea1345c8710c97748e516684803db7e422501e86c',
     armv7l: 'fc41489cf90b691c2ad84c4ea1345c8710c97748e516684803db7e422501e86c',
     x86_64: 'a9971e38c3caba91bc21fadfb42134aea915c0a92cd2bc7ce8fca5216fba062c'
  })

  depends_on 'at_spi2_core' => :build
  depends_on 'cairo' # R
  depends_on 'fontconfig' # R
  depends_on 'fribidi' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'graphene' # R
  depends_on 'gtk3' => :build
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'libsoup' => :build
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build

  gnome
  no_upstream_update

  def self.patch
    system "sed -i 's/-fstack-protector-strong/-flto=auto/g' meson.build"
  end

  meson_options '-Db_asneeded=true -Dbuild-testsuite=false'
end
