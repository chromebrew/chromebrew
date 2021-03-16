require 'package'

class Gnome_online_accounts < Package
  description 'Single sign-on framework for GNOME'
  homepage 'https://wiki.gnome.org/Projects/GnomeOnlineAccounts'
  @_ver = '3.38.1'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-online-accounts/-/archive/#{@_ver}/gnome-online-accounts-#{@_ver}.tar.bz2"
  source_sha256 '8547314b6e6b4c2296100f6962e30f13f583b0dad73e32a45b592f751a8f77f3'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_online_accounts-3.38.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_online_accounts-3.38.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_online_accounts-3.38.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_online_accounts-3.38.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd517c3134aad43d117331c3b67b5aedd56fe1fbf8e2f4172666e765cf5277340',
     armv7l: 'd517c3134aad43d117331c3b67b5aedd56fe1fbf8e2f4172666e765cf5277340',
       i686: '4385bcd168c23381e034690659d7f42523abe6286e726322cb17ccf65efa643e',
     x86_64: '93fc631810c3fde3e74d22d5249897bcf915683c85b9639d0988af48178d20d8'
  })

  depends_on 'webkit2gtk'
  depends_on 'json_glib'
  depends_on 'libnotify'
  depends_on 'rest'
  depends_on 'libsecret'
  depends_on 'gcr'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'vala' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dgtk_doc=true \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
