require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "5.0.1-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '27b51ca67ddffee053f7855a700a798362f1e9b17bd0fb539fd919c05f10ee32',
     armv7l: '27b51ca67ddffee053f7855a700a798362f1e9b17bd0fb539fd919c05f10ee32',
       i686: '5157c4c1cda2d557a800a9a2ee24b74a8fa439fadcf1717d7d875ed20e02ee8b',
     x86_64: '068714972570f786c2f424d06e857228f7d524d124bad4e245aec196b82b850b'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
