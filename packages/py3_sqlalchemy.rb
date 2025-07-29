require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.42-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6960aa31308551106dd86c28908ce841440ddc49a330527d6fb4a8d32ab9552d',
     armv7l: '6960aa31308551106dd86c28908ce841440ddc49a330527d6fb4a8d32ab9552d',
       i686: '3021f6266145b87f74f64223b1f86aa5f25724773b0cc5c532669247d0de64d7',
     x86_64: 'e5f83c8a1b424a1475c6bc82f53f47b38c0ab67907d2569d07f5346c095b2fa1'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  no_source_build
end
