require 'buildsystems/meson'

class Gnome_autoar < Meson
  description 'Automatic archives creating and extracting library'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-autoar'
  version '0.4.5'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-autoar.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be22a8c437f6916eebe87b092c8794f8d2ac13810d1ccbdd277d1395d0a7ea76',
     armv7l: 'be22a8c437f6916eebe87b092c8794f8d2ac13810d1ccbdd277d1395d0a7ea76',
     x86_64: 'a6815d9a2eabb96783722130ff63fd0d06658966bf373f7e1f00e8e981dc28fb'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'cairo' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'libarchive' # R
  depends_on 'libjpeg_turbo' => :build
  depends_on 'vala' => :build

  gnome
end
