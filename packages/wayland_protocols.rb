require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.32'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff6f55bfbbb6f5db5beb2e63d4b65b6ce04028bb08edb3e84102ee3e19c9439d',
     armv7l: 'ff6f55bfbbb6f5db5beb2e63d4b65b6ce04028bb08edb3e84102ee3e19c9439d',
       i686: '5979ebcc37b27f2b9509a61ee319b99f8650afa9043f964b4d4d7faa990c6317',
     x86_64: 'ae4daf867ad5c1f35ede366d9d8fa6a687b2a97517a1e469044e57a306f4274b'
  })

  depends_on 'wayland' # L

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dtests=false \
     builddir"
    system 'meson configure --no-pager builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
