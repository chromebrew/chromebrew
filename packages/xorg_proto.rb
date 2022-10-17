require 'buildsystems/meson/v1'

class Xorg_proto < Meson_v1
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/'
  version '2022.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2022.2.tar.xz'
  source_sha256 '5d13dbf2be08f95323985de53352c4f352713860457b95ccaf894a647ac06b9e'
end
