require 'buildsystems/pip'

class Py3_dnspython < Pip
  description 'DNSPython is a DNS toolkit.'
  homepage 'https://www.dnspython.org/'
  version "2.9.2-#{CREW_PY_VER}"
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e83d8fd6cb03e2e5dea9449b607f241575023a8c0a6b5f412d136f633b29275',
     armv7l: '8e83d8fd6cb03e2e5dea9449b607f241575023a8c0a6b5f412d136f633b29275',
       i686: '39064e82fbe38c2ed54e5c074841db52d9787d007b9473d79fd5e0485d2b7646',
     x86_64: '760db373bcae3b30550f866b3c00ced7c3105816c77b0aa05bfb2640c701f4c4'
  })

  depends_on 'python3' => :logical

  no_source_build
end
