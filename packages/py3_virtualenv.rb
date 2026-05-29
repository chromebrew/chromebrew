require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.4.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9de6eb95396bc272fb6c4970c57cc4f1785eade6a0c30aa1ae6ee1c449e0fb6d',
     armv7l: '9de6eb95396bc272fb6c4970c57cc4f1785eade6a0c30aa1ae6ee1c449e0fb6d',
       i686: '32f20138d9d3226826c448f08753dd020e926834120d940e783f413418fb8cc1',
     x86_64: '3d61d7ed5ba3556bec43238b8f2ca7f938d2be154a4cd17743171fa157e4ec4e'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
