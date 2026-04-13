require 'buildsystems/meson'

class Gnome_online_accounts < Meson
  description 'Single sign-on framework for GNOME'
  homepage 'https://wiki.gnome.org/Projects/GnomeOnlineAccounts'
  version '3.58.1'
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-online-accounts.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a42eca99b8b1d0c4fc2e776f34e2936e23ac2e97a2d79deabb4cabd345e9f17',
     armv7l: '4a42eca99b8b1d0c4fc2e776f34e2936e23ac2e97a2d79deabb4cabd345e9f17',
     x86_64: 'a23de974cfb2506b614c2395b63f8ea0052ad4984b6a4193562715c76116538b'
  })

  depends_on 'gcr_4' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk4' => :library
  depends_on 'gtk_doc' => :build
  depends_on 'json_glib' => :library
  depends_on 'keyutils' => :executable
  depends_on 'keyutils' => :library
  depends_on 'krb5' => :executable
  depends_on 'krb5' => :library
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
