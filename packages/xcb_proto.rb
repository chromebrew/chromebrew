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
       i686: '1cb7c1d6ce5ad89046f72916502fa80231d61c01a09e4bfceaa2cd44aebf0a5a',
     x86_64: '88f74f948ff0e3019d3de251fe2875833b2abe6195be35d7ba97d1327ece0f3c'
  })

  depends_on 'python3'
end
