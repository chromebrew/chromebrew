require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.20-1'
  compatibility 'all'
  source_url 'https://wayland.freedesktop.org/releases/wayland-protocols-1.20.tar.xz'
  source_sha256 '9782b7a1a863d82d7c92478497d13c758f52e7da4f197aa16443f73de77e4de7'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.20-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.20-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.20-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.20-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '1decd76dce195360e3b2879b7a1ee63efefc64b437faa98e9ff5c833758730d2',
      armv7l: '1decd76dce195360e3b2879b7a1ee63efefc64b437faa98e9ff5c833758730d2',
        i686: '6ff5c74feef6541c342f7393fb2df70e4ec121f4b94d55f254bfa28c6e3e3dc0',
      x86_64: 'a88f0f3c10c6108c6b9b584a1c74998d8a49ea70cb022f6350d3df129f120a72',
  })

  depends_on 'wayland'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
