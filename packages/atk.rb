require 'package'

class Atk < Package
  description 'ATK provides the set of accessibility interfaces that are implemented by other tookits and applications'
  homepage 'https://developer.gnome.org/atk'
  version '2.36'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/atk/2.36/atk-2.36.0.tar.xz'
  source_sha256 'fb76247e369402be23f1f5c65d38a9639c1164d934e40f6a9cf3c9e96b652788'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/atk-2.36-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/atk-2.36-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/atk-2.36-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/atk-2.36-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '59b8ccc0c669036ac52af1ce1ae2935f003b373c8fad8ce6825ded95bc1b2a29',
     armv7l: '59b8ccc0c669036ac52af1ce1ae2935f003b373c8fad8ce6825ded95bc1b2a29',
       i686: 'e96cb35a8e5855e32a7ab39f7edf67f7dc19eed74c0a3a63abf4d2ffb4b3db67',
     x86_64: '6e8cf2d268ac84d9cccb189167449882aa19489093dacedf6697165049d3fa58',
  })

  depends_on 'gobject_introspection'
  depends_on 'six' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} build"
    system 'meson configure build'
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
