require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.31'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.31_armv7l/wayland_protocols-1.31-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.31_armv7l/wayland_protocols-1.31-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.31_i686/wayland_protocols-1.31-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.31_x86_64/wayland_protocols-1.31-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b194722496853277d09a7142058deb8eac0acad7faa8105cf09e3c4b3fe2621b',
     armv7l: 'b194722496853277d09a7142058deb8eac0acad7faa8105cf09e3c4b3fe2621b',
       i686: '1737ff32aa44e349783cb585622ba746ad2b59a16ec102f9c91d4a1e6649cad2',
     x86_64: '295b817528dc9622ab7cf215c82eb94159149ddf597a4729e74af1c4e09bfbf3'
  })

  depends_on 'wayland' # L

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dtests=false \
     builddir"
    system 'meson configure builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
