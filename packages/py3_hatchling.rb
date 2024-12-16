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
    aarch64: '090259a56a1746bfb2ccf91acdeddfe6f1d03954c81884b8b71d3a7e47cdbdfb',
     armv7l: '090259a56a1746bfb2ccf91acdeddfe6f1d03954c81884b8b71d3a7e47cdbdfb',
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
