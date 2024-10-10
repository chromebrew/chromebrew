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
    aarch64: '4e1aee2ef9e84278ca1366115016424417579f2d1fe7a6d0aa5ef20a0a6e1e0d',
     armv7l: '4e1aee2ef9e84278ca1366115016424417579f2d1fe7a6d0aa5ef20a0a6e1e0d',
       i686: 'fa3b4bbe7269d23fb3a5078f9346e09e580903bfb11a8267e30e053d45c58c5f',
     x86_64: 'f00bf9b98cf4db31f7f77bd6df11b79e4f12d89685ce7d38e99ab5027137d8ce'
  })

  depends_on 'py3_hatchling' => :build
  depends_on 'py3_soupsieve'
  depends_on 'python3' => :build

  no_source_build
end
