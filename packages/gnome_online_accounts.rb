require 'buildsystems/meson'

class Gnome_online_accounts < Meson
  description 'Single sign-on framework for GNOME'
  homepage 'https://wiki.gnome.org/Projects/GnomeOnlineAccounts'
  version '3.56.1'
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-online-accounts.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f3e757ec845a19c0f1e29547c43b4d785e721bd309ee035437317a2d193b5e0',
     armv7l: '9f3e757ec845a19c0f1e29547c43b4d785e721bd309ee035437317a2d193b5e0',
     x86_64: 'deabb79fdf85df0f316ac73d8e0c97540a55b9d601eba9b21b29f0d1bbcda8b6'
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
