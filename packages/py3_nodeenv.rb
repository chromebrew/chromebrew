require 'buildsystems/pip'

class Py3_nodeenv < Pip
  description 'Tool to create isolated node.js environments.'
  homepage 'https://github.com/ekalinin/nodeenv'
  version "1.12.0-#{CREW_PY_VER}"
  license 'Copyright (c) 2011, Eugene Kalinin'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '67fd47ddea11e6e47ff5d253188492031f3d8b834fbb868465f8487d31a0d958',
     armv7l: '67fd47ddea11e6e47ff5d253188492031f3d8b834fbb868465f8487d31a0d958',
       i686: 'f7b68f7791bfb42b850326e3c6504eb74ddee63cfd5f1294dc607961566429c0',
     x86_64: '2d682a9410fb9faad6ce3b8ca9796e0f6b490e6b82487ffb637cb3719937bc71'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
