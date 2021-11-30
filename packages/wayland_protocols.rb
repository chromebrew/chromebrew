require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.24'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.24_armv7l/wayland_protocols-1.24-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.24_armv7l/wayland_protocols-1.24-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.24_i686/wayland_protocols-1.24-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_protocols/1.24_x86_64/wayland_protocols-1.24-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c633f35563e10ddb018f0d546f5d3a3414d60981f477fee9e66c638018e4fe2a',
     armv7l: 'c633f35563e10ddb018f0d546f5d3a3414d60981f477fee9e66c638018e4fe2a',
       i686: '024424651a90ae99a88c7f7f5fef9b207b1c74e67574f3e86fb09b9d2a051723',
     x86_64: '985f6edc42f6a1bded7c38563ca45cfa2fa51d9d1128dfa4445998604062db7a'
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
