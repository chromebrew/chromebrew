require 'buildsystems/meson'

class Xorg_proto < Meson
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/'
  version '2022.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/proto/xorgproto.git'
  git_hashtag "xorgproto-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_proto/2022.2_armv7l/xorg_proto-2022.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_proto/2022.2_armv7l/xorg_proto-2022.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_proto/2022.2_i686/xorg_proto-2022.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_proto/2022.2_x86_64/xorg_proto-2022.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4f29c3f12e684e8e3de289a0ca8810e763ddb96c3bf3a686baf0392d4d8ced66',
     armv7l: '4f29c3f12e684e8e3de289a0ca8810e763ddb96c3bf3a686baf0392d4d8ced66',
       i686: '0592845ac3053d91b8158bd186c629d2a0b372a95b5d0e30c06b71a5fffe4e95',
     x86_64: '21802c99d382be50f69e613dee68e25821b6a09ba4b6833309899c76dce9789f'
  })
end
