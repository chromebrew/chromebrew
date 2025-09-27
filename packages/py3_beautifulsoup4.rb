require 'buildsystems/pip'

class Py3_beautifulsoup4 < Pip
  description 'BeautifulSoup is a screen-scraping library.'
  homepage 'https://www.crummy.com/software/BeautifulSoup/'
  version "4.14.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '104bb0b33312d24497316ffe4adbf201ddce7458f221b152cf7b548a43135a46',
     armv7l: '104bb0b33312d24497316ffe4adbf201ddce7458f221b152cf7b548a43135a46',
       i686: 'b5cd4e5ba861564e65b06a1ae18fb88db5acef113143d2fd0d30bb67f7d34a91',
     x86_64: '3e06f49e5400a538f3746fd4624aad6754d91a5515d5835e409828c742f95751'
  })

  depends_on 'py3_hatchling' => :build
  depends_on 'py3_soupsieve'
  depends_on 'python3' => :build

  no_source_build
end
