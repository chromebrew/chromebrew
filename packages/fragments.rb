require 'package'

class Fragments < Package
  description 'Fragments is an easy to use BitTorrent client for the GNOME desktop environment.'
  homepage 'https://gitlab.gnome.org/World/Fragments'
  @_ver = '2.0.2'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/World/Fragments.git'
  git_hashtag @_ver

  depends_on 'dbus'
  depends_on 'glib'
  depends_on 'gtk4'
  depends_on 'pango'
  depends_on 'libadwaita'
  depends_on 'rust' => :build
  gnome

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'samu -C builddir || samu -C builddir || samu -C builddir' # Known bug where transmission-client crate fails to build the first time and succeeds the second or third.
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test'
  end
end
