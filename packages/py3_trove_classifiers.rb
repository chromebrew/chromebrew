require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.12.1.14-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd0cf27b35201a89aba5117f53507ac1442302f601f4b25532b5ca3a5b9f84c6e',
     armv7l: 'd0cf27b35201a89aba5117f53507ac1442302f601f4b25532b5ca3a5b9f84c6e',
       i686: '948f70071ccaa86487afd5ca91708cfaa6eb9871ca69283fb6310724d488e770',
     x86_64: '631d24071e5b0f510253131eeab30b632cf712c3a1d01ba6714cd3278ccc7351'
  })

  depends_on 'python3' => :build

  no_source_build
end
