require 'buildsystems/pip'

class Py3_markitdown < Pip
  description 'Python tool for converting files and office documents to Markdown.'
  homepage 'https://github.com/microsoft/markitdown'
  version "0.1.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c80985bc594b8973c99518ac0e9c9f9ef58862580a606292c3a979eadf1e0517',
     armv7l: 'c80985bc594b8973c99518ac0e9c9f9ef58862580a606292c3a979eadf1e0517',
       i686: '05c5ef241102985cd5342e9f6dd66febd1f1807a6b23a357b4291ce35e0dec90',
     x86_64: '7e20854f11c61577a1f5cc28cbf9bd2603cc7aa3c2eb4ad2b3c696709d703ca9'
  })

  depends_on 'python3' => :logical

  no_source_build
end
