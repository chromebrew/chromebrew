require 'buildsystems/meson'

class Gnome_online_accounts < Meson
  description 'Single sign-on framework for GNOME'
  homepage 'https://wiki.gnome.org/Projects/GnomeOnlineAccounts'
  version '3.39.92'
  license 'LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/archive/#{version}/gnome-online-accounts-#{version}.tar.bz2"
  source_sha256 '89e27c886c0266b8c84a56dbb0fb0baefa704dd4d0ec47dd154a26590554adc9'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'c99efb0ee72e176460beea2b7e75fb980d48f6f1fe56725437631fc17a804cc6',
     armv7l: 'c99efb0ee72e176460beea2b7e75fb980d48f6f1fe56725437631fc17a804cc6',
     x86_64: 'bd8c7198503bbe8aed993679a6d1019bc3245dbfd73f9de404d92189b7c0a1d3'
  })

  depends_on 'webkit2gtk'
  depends_on 'json_glib'
  depends_on 'libnotify'
  depends_on 'rest'
  depends_on 'libsecret'
  depends_on 'gcr'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'vala' => :build

  gnome

  meson_options '-Dgtk_doc=true'
end
