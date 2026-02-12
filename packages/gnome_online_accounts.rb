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
    aarch64: 'b30820d5e23744c70eb55ce65304425b67b922db16da6b2c48cfea36a12d0f1d',
     armv7l: 'b30820d5e23744c70eb55ce65304425b67b922db16da6b2c48cfea36a12d0f1d',
     x86_64: '1e9c820085b635b699aee3d3c07949910726b75eb6f4ca706f44a60e98aa19f8'
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
