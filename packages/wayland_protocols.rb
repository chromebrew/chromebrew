require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.30'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.30_armv7l/wayland_protocols-1.30-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.30_armv7l/wayland_protocols-1.30-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.30_i686/wayland_protocols-1.30-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.30_x86_64/wayland_protocols-1.30-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd704fb7b2384861883eca49f4222e83602c92df18c39ab74ae3903ef7c9c7d42',
     armv7l: 'd704fb7b2384861883eca49f4222e83602c92df18c39ab74ae3903ef7c9c7d42',
       i686: 'ed0d349148e03e353cc1e92a02742a5d57c2ab3515e5cc1d673cb47391ee810e',
     x86_64: 'a05dedebc8b60e559b117119ae55275353509bdfce735db5125e01eee2132a9d'
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
