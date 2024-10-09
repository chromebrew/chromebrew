require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "2.6.15-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f8f28a0ca3435c91776c01c339fcaf0296a56dfcd2f05cccd92a2c22bc897a14',
     armv7l: 'f8f28a0ca3435c91776c01c339fcaf0296a56dfcd2f05cccd92a2c22bc897a14',
       i686: '0d66d76549ae8a87a2758057b899d7d2af25bca168f101f17a719a87c9370d3d',
     x86_64: '3af4b3475b5def6826ed34dc73ab7613691630dd67af8a2dc651e03aa3833573'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
