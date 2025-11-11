require 'buildsystems/meson'

class Gcr_4 < Meson
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  version '4.4.0.1'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gcr.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2f4cd4fa3e1a1e55db7ca56256de6f7f05194a11b2e9a9b53329abcdb77528d',
     armv7l: 'a2f4cd4fa3e1a1e55db7ca56256de6f7f05194a11b2e9a9b53329abcdb77528d',
     x86_64: 'd5d63ba6bcde3f421deb072507c063e3602282415dd46d3bbe29996f480d6a37'
  })

  depends_on 'cairo' => :build
  depends_on 'desktop_file_utilities' => :build
  depends_on 'gcc_lib' => :build
  depends_on 'gdk_pixbuf' => :build
  depends_on 'glib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'glibc' # R
  depends_on 'gnupg' => :build
  depends_on 'graphite' => :build
  depends_on 'gtk3' => :build
  depends_on 'gtk4' # R
  depends_on 'gtk4' # R
  depends_on 'hicolor_icon_theme' => :build
  depends_on 'libgcrypt' # R
  depends_on 'libgcrypt' # R
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libsecret' # R
  depends_on 'libsecret' # R
  depends_on 'libxslt' => :build
  depends_on 'p11kit' # R
  depends_on 'p11kit' # R
  depends_on 'pango' # R
  depends_on 'pango' # R
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build

  gnome

  meson_options '-Dgtk_doc=false'
end
