require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.14.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '23862baba1530de95af6581765cf7feb66a59f5487364505ec8603651403bd99',
     armv7l: '23862baba1530de95af6581765cf7feb66a59f5487364505ec8603651403bd99',
       i686: 'd67bb3226135d06eeb8ac7a6d93be3430b01da8a71f3bcc00681c606b05a55e1',
     x86_64: '042bf2e344fbb245297c4a97cdc5380c19e2f24553b1a83f28cf86c602afd7fa'
  })

  depends_on 'python3' => :logical

  no_source_build
end
