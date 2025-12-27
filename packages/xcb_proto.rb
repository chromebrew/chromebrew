require 'buildsystems/autotools'

class Xcb_proto < Autotools
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://xcb.freedesktop.org'
  version "1.17.0-#{CREW_PY_VER}"
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/proto/xcbproto.git'
  git_hashtag "xcb-proto-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3f23bf712b278132f75f6f89096f4bc6a61671784ace3d569c311b52467eb6db',
     armv7l: '3f23bf712b278132f75f6f89096f4bc6a61671784ace3d569c311b52467eb6db',
       i686: '4339e643269e2b9803c789776b4d1539bd89130cdd42590d70a97417c7dc3a6e',
     x86_64: '21e2a4a4bf5040b6f781e50f712f55a73ff8f67c57994d0ccfecfc25cd3382a0'
  })

  depends_on 'python3'
end
