require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.21'
  license 'MIT'
  compatibility 'all'
  source_url 'https://wayland.freedesktop.org/releases/wayland-protocols-1.21.tar.xz'
  source_sha256 'b99945842d8be18817c26ee77dafa157883af89268e15f4a5a1a1ff3ffa4cde5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.21_armv7l/wayland_protocols-1.21-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.21_armv7l/wayland_protocols-1.21-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.21_i686/wayland_protocols-1.21-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.21_x86_64/wayland_protocols-1.21-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '487266d1e54fd7094f0b75184bbea84044304dbbe4d64c9214069ff6cfee4472',
     armv7l: '487266d1e54fd7094f0b75184bbea84044304dbbe4d64c9214069ff6cfee4472',
       i686: '79e0dc6d2724fdc3ca0724a5d04649adf2e88136e3fc1b5a4ee2f4001117cac2',
     x86_64: 'fd5283cabe38f85f245a5dcbb6b946594fefa64a5d0777a5554ee534f985ee56'
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
