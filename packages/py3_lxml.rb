require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "6.0.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9bf55374f51ae5e28cafae18d9a89fd8f96ff8ee78147619d6f7fa1ea54cfe0',
     armv7l: 'f9bf55374f51ae5e28cafae18d9a89fd8f96ff8ee78147619d6f7fa1ea54cfe0',
       i686: '5a447ffd74485b9ab3298dcda7b07bb4039baba42c70bbcecf728357aa28d868',
     x86_64: '186c163f9f58125e127a6118c2461f1f10880bfbf29e478a41d6c6ed6ee0cb37'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'py3_cython' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R
  no_source_build
end
