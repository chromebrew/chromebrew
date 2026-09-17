require 'buildsystems/pip'

class Py3_flit < Pip
  description 'Flit provides simplified packaging of Python modules.'
  homepage 'https://flit.pypa.io/'
  version "4.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d1400e90b2e4e2d7f72015cf6a3e3c610ef9653cd86c63880b3e59138ff0cf0',
     armv7l: '1d1400e90b2e4e2d7f72015cf6a3e3c610ef9653cd86c63880b3e59138ff0cf0',
       i686: '8bcc12b66848b921ee1c8b806af2edfaf7b127305e38c8f7dddb0ab3293fae63',
     x86_64: '96f454062b03785cce9d38327b6cc28b5eab7e793305ade12b83c659d20d63d3'
  })

  depends_on 'py3_docutils'
  depends_on 'py3_flit_core'
  depends_on 'py3_tomli'
  depends_on 'py3_tomli_w'
  depends_on 'python3' => :logical

  no_source_build
end
