require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.25'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.25_armv7l/wayland_protocols-1.25-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.25_armv7l/wayland_protocols-1.25-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.25_i686/wayland_protocols-1.25-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.25_x86_64/wayland_protocols-1.25-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2b7f7735462285555096b5200b63323318b6da02ebf36e1da32320bba202b72f',
     armv7l: '2b7f7735462285555096b5200b63323318b6da02ebf36e1da32320bba202b72f',
       i686: '48758272211b03ee657e4cafaf7e71301da90623723cb02676fe5313e810f6c4',
     x86_64: '5d21d13aa6c092e9287091071411f732cac0353175bab2ba4f5f8b8999762be6'
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
