require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.20'
  source_url 'https://wayland.freedesktop.org/releases/wayland-protocols-1.20.tar.xz'
  source_sha256 '9782b7a1a863d82d7c92478497d13c758f52e7da4f197aa16443f73de77e4de7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.20-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8a227186e165292076d56b1ffc8db3c49180359f7a19a464987e3d1c6d9343df',
     armv7l: '8a227186e165292076d56b1ffc8db3c49180359f7a19a464987e3d1c6d9343df',
       i686: '6d153b9a6856e0207c0ff0ca98bba121fde245ab79c8a17a77e65071350b85fd',
     x86_64: '01f3d8f5383c1fd9e52b4f5b001c8d3cb605871dff52a3a20dbe38852bf23a3b',
  })

  depends_on 'wayland'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
