require 'buildsystems/autotools'

class Xcb_proto < Autotools
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://xcb.freedesktop.org'
  @_ver = '1.16.0'
  version "#{@_ver}-#{CREW_PY_VER}"
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/proto/xcbproto.git'
  git_hashtag "xcb-proto-#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11bb582fa6333d511521cc297b658ee77bd6962e28e44d3dc261804dc30ff5d8',
     armv7l: '11bb582fa6333d511521cc297b658ee77bd6962e28e44d3dc261804dc30ff5d8',
       i686: '822d361f75dcc35464840a465385b6cf016b7ff463e916d7a8533962240bb230',
     x86_64: '7411b8251017a64592afd72ccb26e9092900ff5b9841a6be1e6d2383615d6545'
  })

  depends_on 'python3'
end
