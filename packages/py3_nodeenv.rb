require 'buildsystems/pip'

class Py3_nodeenv < Pip
  description 'Tool to create isolated node.js environments.'
  homepage 'https://github.com/ekalinin/nodeenv'
  version "1.10.0-#{CREW_PY_VER}"
  license 'Copyright (c) 2011, Eugene Kalinin'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd328a245ab97db6c64cdd9765acba0b8be7030cb6f9ecbef44497f02ccc2e7e8',
     armv7l: 'd328a245ab97db6c64cdd9765acba0b8be7030cb6f9ecbef44497f02ccc2e7e8',
       i686: 'd310a507e8045191eded06cab54ba14490d1b56de65006447ee5dabb103b55ae',
     x86_64: '367a45ead11a04c05f946f4b0570b0a37fb59b3121a324c1c50f9cf134de2a4f'
  })

  depends_on 'python3'

  no_source_build
end
