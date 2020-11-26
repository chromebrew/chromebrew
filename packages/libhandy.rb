require 'package'

class Libhandy < Package
  description 'The aim of the handy library is to help with developing UI for mobile devices using GTK/GNOME.'
  homepage 'https://gitlab.gnome.org/GNOME/libhandy/'
  version '1.0.2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libhandy/-/archive/1.0.2/libhandy-1.0.2.tar.bz2'
  source_sha256 '5b1ceebf80a82bb56804370d88481b8a4affe5d33f13a7fd06905135cceaaf88'


  depends_on 'vala'
  
  def self.prebuild
    system "sed -i 's,-fstack-protector-strong,-fno-stack-protector,' meson.build"
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} build"
    system 'ninja -v -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
