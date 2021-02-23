require 'package'

class Xcb_proto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.14.1'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/proto/xcbproto/-/archive/xcb-proto-1.14.1/xcbproto-xcb-proto-1.14.1.tar.bz2'
  source_sha256 '186a3ceb26f9b4a015f5a44dcc814c93033a5fc39684f36f1ecc79834416a605'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.14.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.14.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.14.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.14.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '44acc3a13eef02910837f702f2375cfe9b4ec84b29b21901dde05a20bb03cd5f',
     armv7l: '44acc3a13eef02910837f702f2375cfe9b4ec84b29b21901dde05a20bb03cd5f',
       i686: '43bd2fe4d681f2a13deef0eeb5b1e22850dc53c836613a18fe73f1c77267a03a',
     x86_64: '6f7ccb0abc93a0b8156993ab46aa096bc087ae1c82eac33ef8924d7d69f3027f'
  })

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
        LDFLAGS='-flto=auto' \
        ./autogen.sh \
        #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
