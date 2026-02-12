require 'buildsystems/pip'

class Py3_pycparser < Pip
  description 'PyCParser is a complete C99 parser in pure Python.'
  homepage 'https://github.com/eliben/pycparser/'
  version "3.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '525f46f09b243477480bf2b9538069adfeb4cda3e667c1e3136906d5c7af568d',
     armv7l: '525f46f09b243477480bf2b9538069adfeb4cda3e667c1e3136906d5c7af568d',
       i686: 'fea92655d85fe8bba06a6f97db0512762ab482491b5346bb211c77380cf75590',
     x86_64: 'aebd0fc2fad20352737217f6dbb04480bde9d8cf7aad41d47fdbd172cbed503d'
  })

  depends_on 'python3' => :build

  no_source_build
end
