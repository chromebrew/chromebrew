require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.3.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46b20f45136a005aa51b67fd5cf2ed92329c6575b68c01b3b653f4d5f0e967e4',
     armv7l: '46b20f45136a005aa51b67fd5cf2ed92329c6575b68c01b3b653f4d5f0e967e4',
       i686: 'd1106dee4d048ed09a01310b69ac265096c32b2ca6b3c7e56a0f2ad340a9b1bc',
     x86_64: 'fd4e98cd5c1905ae59a1d69cd75247d6d1c3b07e4a9e46bf4f3a03fb6ea313e7'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
