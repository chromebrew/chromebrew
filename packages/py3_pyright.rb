require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.399-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bfb7f8c201e0f946ddf39d0245ef61ba1a7a15d60633e7e720daeaa251e4e497',
     armv7l: 'bfb7f8c201e0f946ddf39d0245ef61ba1a7a15d60633e7e720daeaa251e4e497',
       i686: 'f14c202277b3cfe2460d7c65946cca3acc221f304397d649afc8cc245d3c78f0',
     x86_64: '29a3c1091071aae7b9f64c9b93340619ec8d025248ccbd771c37d7576ebee83d'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
