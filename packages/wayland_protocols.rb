require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients'
  homepage 'https://wayland.freedesktop.org'
  version '1.9'
  source_url 'https://wayland.freedesktop.org/releases/wayland-protocols-1.9.tar.xz'
  source_sha256 '666b72de30ca3b70c2b54ccc9e8114cb520e76db224c816b5e23501099174f75'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b1c7bf17d30ff2335dafdbd2c57bb8769bfe54f8a2342d70af06fbf0a2adc51f',
     armv7l: 'b1c7bf17d30ff2335dafdbd2c57bb8769bfe54f8a2342d70af06fbf0a2adc51f',
       i686: '11d26d2ca2b5e960b71e44573ebeba6c601e3e9e3d0e4614972c66cd8316145e',
     x86_64: '5c1f8913e2ff2ee59dc8080b8c076383caf693890b20bbf08113d08f7fb6199e',
  })

  depends_on 'libwayland'
  
  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
