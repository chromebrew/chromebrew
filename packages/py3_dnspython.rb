require 'buildsystems/pip'

class Py3_dnspython < Pip
  description 'DNSPython is a DNS toolkit.'
  homepage 'https://www.dnspython.org/'
  version "2.8.0-#{CREW_PY_VER}"
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f58bcfc5adbfb8b8f558f1abcd80cb86579073b1c427cc36b7f99149f6d2d4d3',
     armv7l: 'f58bcfc5adbfb8b8f558f1abcd80cb86579073b1c427cc36b7f99149f6d2d4d3',
       i686: '062585bc71fee046d35c5ef62a1b9b38d441ccfcd3097a63ad432a45be5788ad',
     x86_64: '83595d99847317e5d9d0856ac99c8727f7596fcfa90c6d9f606aea5d67de5e17'
  })

  depends_on 'python3' => :build

  no_source_build
end
