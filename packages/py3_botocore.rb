require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.94-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3359b969c318bcd46a1ca8499c630d76c06679ca1b8590ea86ccc924b17e82bd',
     armv7l: '3359b969c318bcd46a1ca8499c630d76c06679ca1b8590ea86ccc924b17e82bd',
       i686: 'f8e1f3ad62f0068121c55162b2616415fa7a51455352ab7e8d2b53a2c837110a',
     x86_64: 'd36c86b31c76dd8d8afad7122b36ed0505a962f49955553ef7369869e7140a78'
  })

  depends_on 'python3' => :logical

  no_source_build
end
