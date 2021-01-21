require 'package'

class Libhandy < Package
  description 'The aim of the handy library is to help with developing UI for mobile devices using GTK/GNOME.'
  homepage 'https://gitlab.gnome.org/GNOME/libhandy/'
  version '1.0.2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libhandy/-/archive/1.0.2/libhandy-1.0.2.tar.bz2'
  source_sha256 '5b1ceebf80a82bb56804370d88481b8a4affe5d33f13a7fd06905135cceaaf88'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ccb7edee4b44c0e0d466722194e2f5b331e5893c2442f27ccbbe86cf0eea004a',
     armv7l: 'ccb7edee4b44c0e0d466722194e2f5b331e5893c2442f27ccbbe86cf0eea004a',
       i686: 'ab4a4302ff0ad48c3edaedfe37cc930389dc3984ba9ab74de1e79636d52bc9c7',
     x86_64: 'c865b663caf4b2ae0da32a59f0a719711ed5f4af9d231e5317f921c4cdeb5693',
  })


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
