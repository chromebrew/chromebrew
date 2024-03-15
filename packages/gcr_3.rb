require 'buildsystems/meson'

class Gcr_3 < Meson
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  version '3.41.2'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gcr.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6b12260cf56027ae63abbc3bef251b856a86225dfa0201fc000447a5d630e6d',
     armv7l: 'f6b12260cf56027ae63abbc3bef251b856a86225dfa0201fc000447a5d630e6d',
     x86_64: '4b4ee7084cea205e445117d7dd673f1552b03b33ee95012f566d0920c0ca9216'
  })

  depends_on 'cairo' # R
  depends_on 'desktop_file_utilities' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnupg' => :build
  depends_on 'graphite' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme' => :build
  depends_on 'libgcrypt' # R
  depends_on 'libjpeg' => :build
  depends_on 'libsecret' # R
  depends_on 'libxslt' => :build
  depends_on 'p11kit' # R
  depends_on 'pango' # R
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build

  conflicts_ok # expected conflicts with gcr_4
  gnome

  meson_options '-Dgtk_doc=false'
end
