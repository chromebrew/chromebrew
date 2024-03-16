require 'buildsystems/meson'

class Gnome_online_accounts < Meson
  description 'Single sign-on framework for GNOME'
  homepage 'https://wiki.gnome.org/Projects/GnomeOnlineAccounts'
  version '3.48.1'
  license 'LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-online-accounts.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0837dbb7d9beaa6c321b654faf1f00a641cef5aa6147ae3594cde6ddba2c9749',
     armv7l: '0837dbb7d9beaa6c321b654faf1f00a641cef5aa6147ae3594cde6ddba2c9749',
     x86_64: 'f772cc1cedfbec3606f6b5f50a0740ac042a87d265616ae06676529aa659818f'
  })

  depends_on 'gcr_3' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'json_glib' # R
  depends_on 'krb5' # R
  depends_on 'libnotify' => :build
  depends_on 'libsecret' # R
  depends_on 'libsoup' # R
  depends_on 'libxml2' # R
  depends_on 'rest' # R
  depends_on 'vala' => :build
  depends_on 'webkit2gtk_4_1' # R

  gnome

  meson_options '-Dgtk_doc=false'
end
