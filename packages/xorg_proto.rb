require 'buildsystems/meson/v1'

class Xorg_proto < Meson_v1
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/'
  version '2021.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2021.5.tar.bz2'
  source_sha256 'aa2f663b8dbd632960b24f7477aa07d901210057f6ab1a1db5158732569ca015'

  check? true
end
