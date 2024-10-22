require 'buildsystems/meson'

class Gtksourceview_5 < Meson
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  version '5.13.1'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gtksourceview.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '191105613a3f40d8885ae675a7ccf39f56cc09e716b9ddae7a4a7ab688d931e5',
     armv7l: '191105613a3f40d8885ae675a7ccf39f56cc09e716b9ddae7a4a7ab688d931e5',
     x86_64: 'b000e44594ab4e3154042396d4f46a1b2949d98d964c37d001605a507ca2dc26'
  })

  depends_on 'at_spi2_core' => :build
  depends_on 'cairo' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
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
  depends_on 'vulkan_icd_loader' # R

  gnome
  no_upstream_update

  def self.patch
    system "sed -i 's/-fstack-protector-strong/-flto=auto/g' meson.build"
  end

  meson_options '-Db_asneeded=false -Dbuild-testsuite=false'
end
