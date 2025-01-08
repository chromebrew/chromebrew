require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  version "1.27.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c77be4bea10676a784add5e552b29ad90eb9f82c98dbf2bc07e3225e2c841b02',
     armv7l: 'c77be4bea10676a784add5e552b29ad90eb9f82c98dbf2bc07e3225e2c841b02',
       i686: '9561c9a316f68ed6077b0baf3a2afd04b6fde2f428dfb24c6f78cb00066e3705',
     x86_64: '174da7b286769068a532e51e179c27613fbcbd7ab042e6ff5d1c4be5b06311ae'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :build

  no_source_build
end
