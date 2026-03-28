require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  version "1.29.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5fa9a5ad96b8de23be42551ea25a7af330503cce73f36ebc7320501be057adc7',
     armv7l: '5fa9a5ad96b8de23be42551ea25a7af330503cce73f36ebc7320501be057adc7',
       i686: 'c60ec91cade3110de15eb3e3e7d7745f1fbb252e1beb59e50e4b252db2e043c2',
     x86_64: '4bcd66a8a6ae9331f023f1e31e33a7a35bb534610b1daf2aa384bc6961bb45cf'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :logical

  no_source_build
end
