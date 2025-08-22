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
    aarch64: '7edbdd45a2bc12d3e44b69ebc08770de29c25babfe7c6a58d9202087246ef349',
     armv7l: '7edbdd45a2bc12d3e44b69ebc08770de29c25babfe7c6a58d9202087246ef349',
       i686: 'e78460760fc07db1609433a54ff02bdb46d372beb70f6062960c0f9175c973c2',
     x86_64: 'd09d88686a330443ec246accd1acfe55abaf098c09d3336926a5624a75c0ec26'
  })

  depends_on 'python3'
end
