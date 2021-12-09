require 'package'

class Xcb_proto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://xcb.freedesktop.org'
  version '1.14.1-be9c'
  compatibility 'all'
  license 'MIT-with-advertising'
  source_url 'https://gitlab.freedesktop.org/xorg/proto/xcbproto.git'
  git_hashtag 'be9c255b6baac166966429c4442ddf2c99001bf5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.14.1-be9c_armv7l/xcb_proto-1.14.1-be9c-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.14.1-be9c_armv7l/xcb_proto-1.14.1-be9c-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.14.1-be9c_i686/xcb_proto-1.14.1-be9c-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_proto/1.14.1-be9c_x86_64/xcb_proto-1.14.1-be9c-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ac502155b41156b5b886c04da96ddf3b2c2974dd43bfa15fce706822145a5e32',
     armv7l: 'ac502155b41156b5b886c04da96ddf3b2c2974dd43bfa15fce706822145a5e32',
       i686: '4f799fd7355d0e804dda5d0e5cd5b865cda848c11009b3833622c8860ddc463d',
     x86_64: '141929f0097b500a307aaf359e86b411328ca2d3c65cfba16e17f323f08b64f9'
  })

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./autogen.sh #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
