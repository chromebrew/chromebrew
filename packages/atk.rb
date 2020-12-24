require 'package'

class Atk < Package
  description 'ATK provides the set of accessibility interfaces that are implemented by other tookits and applications'
  homepage 'https://developer.gnome.org/atk'
  version '2.36'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/atk/2.36/atk-2.36.0.tar.xz'
  source_sha256 'fb76247e369402be23f1f5c65d38a9639c1164d934e40f6a9cf3c9e96b652788'


  depends_on 'gobject_introspection'
  depends_on 'six' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} build"
    system "meson configure build"
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end

end
