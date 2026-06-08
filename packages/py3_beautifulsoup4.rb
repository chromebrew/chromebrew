require 'buildsystems/pip'

class Py3_beautifulsoup4 < Pip
  description 'BeautifulSoup is a screen-scraping library.'
  homepage 'https://www.crummy.com/software/BeautifulSoup/'
  version "4.15.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e2818449ac60863efa8d47e4fb0384fedd45c7e1cdc537f5b9784126027632fb',
     armv7l: 'e2818449ac60863efa8d47e4fb0384fedd45c7e1cdc537f5b9784126027632fb',
       i686: '41a26fa7608b7b312dd84d6f3fe97a85cc1fe3d8e5b8c440412976218f90a3cd',
     x86_64: 'af2e10df96168071fb1c6e757d81cd5e6db411d3fb1be5c2affdeff07c79a1a4'
  })

  depends_on 'py3_hatchling' => :build
  depends_on 'py3_soupsieve'
  depends_on 'python3' => :logical

  no_source_build
end
