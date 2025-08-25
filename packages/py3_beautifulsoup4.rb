require 'buildsystems/pip'

class Py3_beautifulsoup4 < Pip
  description 'BeautifulSoup is a screen-scraping library.'
  homepage 'https://www.crummy.com/software/BeautifulSoup/'
  version "4.13.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a161c9462b3890e9b41e6dedf0ae650ddceced395e29b1d9c83e884ff24a673e',
     armv7l: 'a161c9462b3890e9b41e6dedf0ae650ddceced395e29b1d9c83e884ff24a673e',
       i686: '624312edf4e4a5ef6dfe5a1d5ff04f9903ecebcada958e2d5b4033ab7c0b3e3c',
     x86_64: '32786f4cb230dba21ec2e05fa9806b824544d7d0287ca994a085860e8797a322'
  })

  depends_on 'py3_hatchling' => :build
  depends_on 'py3_soupsieve'
  depends_on 'python3' => :build

  no_source_build
end
