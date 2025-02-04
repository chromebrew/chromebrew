require 'buildsystems/pip'

class Py3_beautifulsoup4 < Pip
  description 'BeautifulSoup is a screen-scraping library.'
  homepage 'https://www.crummy.com/software/BeautifulSoup/'
  version "4.13.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fbf5f83cf2e367e7c247d70c5bb21b18503cf9aef76c7810198202b5af7b6f5b',
     armv7l: 'fbf5f83cf2e367e7c247d70c5bb21b18503cf9aef76c7810198202b5af7b6f5b',
       i686: 'f91fa6e0a2329196c83e5481a8f857e12a3d7c9300315e56f386ea4164595f4d',
     x86_64: 'aca0ba6cbaef5dd23432ab3497d0d9b31e16a01cb1155a3c905be8a5d4553fad'
  })

  depends_on 'py3_hatchling' => :build
  depends_on 'py3_soupsieve'
  depends_on 'python3' => :build

  no_source_build
end
