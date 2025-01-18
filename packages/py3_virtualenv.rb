require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.29.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da47fa449a226cb8201a6cb8eee8d0d9de23eb047b6094e403113caee8f60bae',
     armv7l: 'da47fa449a226cb8201a6cb8eee8d0d9de23eb047b6094e403113caee8f60bae',
       i686: 'def121742ed8dd36e2f9fef3053716341390ab431df982e8a2b6939ebe015730',
     x86_64: '2b115fdfb0241c66fcbfab1e4e077717cf71c55bf6cf0ac196624a8f5b080c8c'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
