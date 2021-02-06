require 'package'

class Libevdev < Package
  description 'libevdev is a wrapper library for evdev devices.'
  homepage 'https://www.freedesktop.org/wiki/Software/libevdev'
  version '1.11.0'
  compatibility 'all'
  source_url 'https://www.freedesktop.org/software/libevdev/libevdev-1.11.0.tar.xz'
  source_sha256 '63f4ea1489858a109080e0b40bd43e4e0903a1e12ea888d581db8c495747c2d0'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libevdev-1.11.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libevdev-1.11.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libevdev-1.11.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libevdev-1.11.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3b4008a79759fdb098e2e93a5455aed90965d670d5a4328b67b49f4936584eb6',
     armv7l: '3b4008a79759fdb098e2e93a5455aed90965d670d5a4328b67b49f4936584eb6',
       i686: 'c4d8bad0f712c1cfacc725e7d317be45aa15bb67d281f8d73ca92a9e803dd116',
     x86_64: '6afbae9d141ced6da39edb73127c4e247afd9abeae8a681b3dc8b62b7edc818d'
  })

  depends_on 'doxygen' => :build
  depends_on 'python3' => :build

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
