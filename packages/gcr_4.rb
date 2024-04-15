require 'buildsystems/meson'

class Gcr_4 < Meson
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  version '4.2.1'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gcr.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e58572faeb754019263b877abbc4decc72d4b4982233e7eb1f2e2f72499299df',
     armv7l: 'e58572faeb754019263b877abbc4decc72d4b4982233e7eb1f2e2f72499299df',
     x86_64: 'b93d179f79ed0043efdd02074048119e690b29a2f32c442ef8e56e5355a75952'
  })

  depends_on 'cairo' => :build
  depends_on 'desktop_file_utilities' => :build
  depends_on 'gcc_lib' => :build
  depends_on 'gdk_pixbuf' => :build
  depends_on 'glib' => :build
  depends_on 'glibc' => :build
  depends_on 'gnupg' => :build
  depends_on 'graphite' => :build
  depends_on 'gtk3' => :build
  depends_on 'gtk4' => :build
  depends_on 'hicolor_icon_theme' => :build
  depends_on 'libgcrypt' => :build
  depends_on 'libjpeg' => :build
  depends_on 'libsecret' => :build
  depends_on 'libxslt' => :build
  depends_on 'p11kit' => :build
  depends_on 'pango' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk4' # R
  depends_on 'libgcrypt' # R
  depends_on 'libsecret' # R
  depends_on 'p11kit' # R
  depends_on 'pango' # R

  gnome

  meson_options '-Dgtk_doc=false'
end
