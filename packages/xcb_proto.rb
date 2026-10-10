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
    aarch64: '3b1fbe1217afa18701f7f4dceccd133068f3bc9b0699a66a3ee53cedf23a510f',
     armv7l: '3b1fbe1217afa18701f7f4dceccd133068f3bc9b0699a66a3ee53cedf23a510f',
       i686: '4339e643269e2b9803c789776b4d1539bd89130cdd42590d70a97417c7dc3a6e',
     x86_64: '21e2a4a4bf5040b6f781e50f712f55a73ff8f67c57994d0ccfecfc25cd3382a0'
  })

  depends_on 'python3'
end
