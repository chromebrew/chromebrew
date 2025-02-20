require 'buildsystems/pip'

class Py3_flit_core < Pip
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  version "3.11.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '358a7ea268944112dbefc38d641719433032e41b27393db639dcee2a54ed3c78',
     armv7l: '358a7ea268944112dbefc38d641719433032e41b27393db639dcee2a54ed3c78',
       i686: '7c9814afc327797e0266ebc8cb41be724fc4a6f47a6b7a288839145b605385f3',
     x86_64: 'a3b46f3db82947c3efc63b8d1b52348724c97961a75b09b808320f19db5e5a0f'
  })

  depends_on 'python3'

  no_source_build
end
