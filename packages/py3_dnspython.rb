require 'buildsystems/pip'

class Py3_dnspython < Pip
  description 'DNSPython is a DNS toolkit.'
  homepage 'https://www.dnspython.org/'
  version "2.9.1-#{CREW_PY_VER}"
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d79acbe4134cd5b50e184b94e2f7920492698d6580415a84ef9765c087b2122',
     armv7l: '7d79acbe4134cd5b50e184b94e2f7920492698d6580415a84ef9765c087b2122',
       i686: '122c985bce191241ee93ea6d0ee6e2168249f05c91834a19baf2ebfcbd2031f2',
     x86_64: '07242beeb0cff298ed9f452bf28e7534de0df880aafc22a0145834ecb5a9d51d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
