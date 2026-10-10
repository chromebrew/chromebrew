require 'buildsystems/pip'

class Py3_six < Pip
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://six.readthedocs.io/'
  version "1.17.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b2a1d007d3efc574462fba65cbf5adb5731da88a79ee0972b04a44deaa84468c',
     armv7l: 'b2a1d007d3efc574462fba65cbf5adb5731da88a79ee0972b04a44deaa84468c',
       i686: 'c858182dde3a9eedb0d36ea1a09dd1101eb13970b6f9d309479c6703893d4d33',
     x86_64: 'ba596ddfc767613be4e94856a02b24cd246af35052da9c5f086a13c7641915d8'
  })

  depends_on 'python3' => :logical

  no_source_build
end
