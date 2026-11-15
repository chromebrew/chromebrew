require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.14.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '624e62edabec8332a53f423bc9e0f9eee1b0ed4a0e4a1cb1e7c7d1e8677a0a7d',
     armv7l: '624e62edabec8332a53f423bc9e0f9eee1b0ed4a0e4a1cb1e7c7d1e8677a0a7d',
       i686: 'e3c1e20c44c0fb4ee7c6e4bb866b065c15f5297c6d4edaf25573746f70a8878a',
     x86_64: 'c7ea74d18258f412373be6cb1ea7b00b15d95afb87a5d53fde0fa116ebca9578'
  })

  depends_on 'python3' => :logical

  no_source_build
end
