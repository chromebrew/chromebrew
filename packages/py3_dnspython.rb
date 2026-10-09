require 'buildsystems/pip'

class Py3_dnspython < Pip
  description 'DNSPython is a DNS toolkit.'
  homepage 'https://www.dnspython.org/'
  version "2.9.0-#{CREW_PY_VER}"
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ffc283498f171e5f142521de4048aa5f0f86a43019cb12c3381e6be594c02d6c',
     armv7l: 'ffc283498f171e5f142521de4048aa5f0f86a43019cb12c3381e6be594c02d6c',
       i686: '4f30cb0d758af424b373c91b00e60e2227467ffcd4edfb25edd506bddddac427',
     x86_64: '022617adc7edab12220477cc0e4101e5cdc6500fb2a6d6159d376ef61cc38d1c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
