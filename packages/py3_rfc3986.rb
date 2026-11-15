require 'buildsystems/pip'

class Py3_rfc3986 < Pip
  description 'A Python implementation of RFC 3986 including validation and authority parsing.'
  homepage 'http://rfc3986.readthedocs.io'
  version "2.0.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0067814a656bdd7572378407a2a4d078264c243feef7446eab7e7a975b760d27',
     armv7l: '0067814a656bdd7572378407a2a4d078264c243feef7446eab7e7a975b760d27',
       i686: '9a513a0cea8cb1b145a2a37a62cee450c80af96e301887a9675d36ce766dd212',
     x86_64: '4812f9542a04c074a828542c476230b879e4cdc9ca2be352bfadba7d48094201'
  })

  depends_on 'python3' => :logical

  no_source_build
end
