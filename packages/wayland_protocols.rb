require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.27'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.27_armv7l/wayland_protocols-1.27-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.27_armv7l/wayland_protocols-1.27-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.27_i686/wayland_protocols-1.27-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.27_x86_64/wayland_protocols-1.27-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3b3db1c642712358e5d640729b1b3753f311facf41629c101f7d49df13807e88',
     armv7l: '3b3db1c642712358e5d640729b1b3753f311facf41629c101f7d49df13807e88',
       i686: 'c1ef3b7ee5f3ebe8bbef54898019cfd28b5ac6292efe6cc8b86f3c055536f69c',
     x86_64: '910af346dff46a95b2d75c04ef4273274a3e09344351e98812fa95bc1275638a'
  })

  depends_on 'wayland' # L

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dtests=false \
     builddir"
    system 'meson configure builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
