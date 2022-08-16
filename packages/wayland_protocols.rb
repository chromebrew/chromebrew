require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.26'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.26_armv7l/wayland_protocols-1.26-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.26_armv7l/wayland_protocols-1.26-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.26_i686/wayland_protocols-1.26-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.26_x86_64/wayland_protocols-1.26-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '36cce3df205929ccc72f17d0eb8e0f3dc8b72f3faa48b6e89e2d1677b5e44a27',
     armv7l: '36cce3df205929ccc72f17d0eb8e0f3dc8b72f3faa48b6e89e2d1677b5e44a27',
       i686: 'fedcd9dc71d9d5c28d656dd8e68274034f16fa8581ab270bbd4772c933ae2fb0',
     x86_64: '18135b38a6379d629252357258a8d664151b88a07ad0591376e2c8803df2e5d9'
  })

  depends_on 'wayland'

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
