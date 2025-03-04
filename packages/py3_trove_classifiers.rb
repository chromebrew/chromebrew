require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.3.3.18-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '628e4b1c5df860e382f8ccba8f7dabc81f1fd39d28ab8a814b015af3dd373a5a',
     armv7l: '628e4b1c5df860e382f8ccba8f7dabc81f1fd39d28ab8a814b015af3dd373a5a',
       i686: 'f13c3c0625df077ad9a90bb2c5e914cc61d36f356832dd7d853e62d3847e548c',
     x86_64: '0dadee8ef47da47960c4bb5bc9b148561e8e030d1a604f851700811ebeaa02a7'
  })

  depends_on 'python3' => :build

  no_source_build
end
