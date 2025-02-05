require 'buildsystems/pip'

class Py3_beautifulsoup4 < Pip
  description 'BeautifulSoup is a screen-scraping library.'
  homepage 'https://www.crummy.com/software/BeautifulSoup/'
  version "4.13.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fbf5f83cf2e367e7c247d70c5bb21b18503cf9aef76c7810198202b5af7b6f5b',
     armv7l: 'fbf5f83cf2e367e7c247d70c5bb21b18503cf9aef76c7810198202b5af7b6f5b',
       i686: '74ba5ac4fec45ae67edd76d56c216c5f75c24ebbcd5b77aad935dd394ccb34e9',
     x86_64: 'aca0ba6cbaef5dd23432ab3497d0d9b31e16a01cb1155a3c905be8a5d4553fad'
  })

  depends_on 'py3_hatchling' => :build
  depends_on 'py3_soupsieve'
  depends_on 'python3' => :build

  no_source_build
end
