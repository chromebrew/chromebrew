require 'buildsystems/meson/v1'

class Xorg_proto < Meson_v1
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/'
  version '2022.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2022.1.tar.bz2'
  source_sha256 '1d2dcc66963f234d2c1e1f8d98a0d3e8725149cdac0a263df4097593c48bc2a6'
end
