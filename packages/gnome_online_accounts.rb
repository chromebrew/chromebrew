require 'buildsystems/meson'

class Gnome_online_accounts < Meson
  description 'Single sign-on framework for GNOME'
  homepage 'https://wiki.gnome.org/Projects/GnomeOnlineAccounts'
  version '3.56.4'
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-online-accounts.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd10546f2bbd75de9d6c9090ae9bc93836dcb43b48e6a4f1fd0024f1ebdd6c43b',
     armv7l: 'd10546f2bbd75de9d6c9090ae9bc93836dcb43b48e6a4f1fd0024f1ebdd6c43b',
     x86_64: 'f4b4881655f06ffc020b279566352279979bc087a7eb4f104a9d2a4a8c65a4ee'
  })

  depends_on 'gcr_4' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk4' # R
  depends_on 'gtk_doc' => :build
  depends_on 'json_glib' # R
  depends_on 'keyutils' # R
  depends_on 'krb5' # R
  depends_on 'libadwaita' # R
  depends_on 'libnotify' => :build
  depends_on 'libsecret' # R
  depends_on 'libsoup' # R
  depends_on 'libxml2' # R
  depends_on 'rest' # R
  depends_on 'vala' => :build

  gnome

  meson_options '-Dgtk_doc=false'
end
