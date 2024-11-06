require 'buildsystems/pip'

class Py3_beautifulsoup4 < Pip
  description 'BeautifulSoup is a screen-scraping library.'
  homepage 'https://www.crummy.com/software/BeautifulSoup/'
  version "4.12.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b425aef91a969b8db3172d16c41ac3cbba1036d26b8a0b3150a58f706fa97007',
     armv7l: 'b425aef91a969b8db3172d16c41ac3cbba1036d26b8a0b3150a58f706fa97007',
       i686: '17bdfbbbb507e40b1a1ec70d0048faef832f308603e500995f3284bde90eddd5',
     x86_64: 'f00bf9b98cf4db31f7f77bd6df11b79e4f12d89685ce7d38e99ab5027137d8ce'
  })

  depends_on 'py3_hatchling' => :build
  depends_on 'py3_soupsieve'
  depends_on 'python3' => :build

  no_source_build
end
