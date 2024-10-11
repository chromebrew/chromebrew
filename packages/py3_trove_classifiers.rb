require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2024.10.11-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8948fc6aacd0dcc5ad4f4f94d5e31ed2ad38331d7aa6ca29f120bdce92138429',
     armv7l: '8948fc6aacd0dcc5ad4f4f94d5e31ed2ad38331d7aa6ca29f120bdce92138429',
       i686: 'f2d5d92bfe11b0a9470024fb4e0e403c891a1f5aac5a90248c77c7bea3322f8f',
     x86_64: 'f292185f36e7502c24f14d803408932a4066ca76e3461276661db5ae0b03e98d'
  })

  depends_on 'python3' => :build

  no_source_build
end
