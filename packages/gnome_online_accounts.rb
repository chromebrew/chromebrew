require 'package'

class Gnome_online_accounts < Package
  description 'Single sign-on framework for GNOME'
  homepage 'https://wiki.gnome.org/Projects/GnomeOnlineAccounts'
  version '3.39.92'
  license 'LGPL-2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/archive/#{version}/gnome-online-accounts-#{version}.tar.bz2"
  source_sha256 '89e27c886c0266b8c84a56dbb0fb0baefa704dd4d0ec47dd154a26590554adc9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_online_accounts/3.39.92_armv7l/gnome_online_accounts-3.39.92-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_online_accounts/3.39.92_armv7l/gnome_online_accounts-3.39.92-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_online_accounts/3.39.92_i686/gnome_online_accounts-3.39.92-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_online_accounts/3.39.92_x86_64/gnome_online_accounts-3.39.92-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c99efb0ee72e176460beea2b7e75fb980d48f6f1fe56725437631fc17a804cc6',
     armv7l: 'c99efb0ee72e176460beea2b7e75fb980d48f6f1fe56725437631fc17a804cc6',
       i686: 'c5d6803aedb9f3ce4d17eefb958543c58ae6affc0c360d745091a846819e1375',
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

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dgtk_doc=true \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
