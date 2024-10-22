require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.385-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e86f736612714dc5d2a8ba028cd44763af9f62ee54e565a98d60f858b32918f9',
     armv7l: 'e86f736612714dc5d2a8ba028cd44763af9f62ee54e565a98d60f858b32918f9',
       i686: '0534e4599eea7b684eb730e91807e1ca1454f7f9b364f9c4e27b08a65ac693f7',
     x86_64: '482d464ebd79cc8d5afa55284eadb2a412b9adef3572c9476ad7977dc1f2aab7'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
