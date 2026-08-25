require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.11.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18942e11f284a7f68afac062ab66d78e479f638be258834ff290b9538d07f18e',
     armv7l: '18942e11f284a7f68afac062ab66d78e479f638be258834ff290b9538d07f18e',
       i686: '83d04e45d7c3fa0845dbe0b8f8fbb43726d3a004edd48e57e575137bcdafb3a8',
     x86_64: '482abca9ba24c949d9c84f59f53257e21adeded1ef5ade2895a165f351aea105'
  })

  depends_on 'python3' => :logical

  no_source_build
end
