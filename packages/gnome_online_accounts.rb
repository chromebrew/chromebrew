require 'buildsystems/meson'

class Gnome_online_accounts < Meson
  description 'Single sign-on framework for GNOME'
  homepage 'https://wiki.gnome.org/Projects/GnomeOnlineAccounts'
  version '3.58.0'
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-online-accounts.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f31e2917cd17396f8064bc612b0b3ea3bdfbad08d5cb8f386d0114eb63d311d',
     armv7l: '4f31e2917cd17396f8064bc612b0b3ea3bdfbad08d5cb8f386d0114eb63d311d',
     x86_64: '34e5e6e06416cd296a8cbda3f161cbe47e86026a55c18237f2e7f5b51b44f41f'
  })

  depends_on 'gcr_4' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk4' => :library
  depends_on 'gtk_doc' => :build
  depends_on 'json_glib' => :library
  depends_on 'keyutils' => :executable
  depends_on 'krb5' => :executable
  depends_on 'libadwaita' => :library
  depends_on 'libnotify' => :build
  depends_on 'libsecret' => :library
  depends_on 'libsoup' => :library
  depends_on 'libxml2' => :library
  depends_on 'libxslt'
  depends_on 'rest' => :library
  depends_on 'vala' => :build

  meson_options '-Ddocumentation=false'
end
