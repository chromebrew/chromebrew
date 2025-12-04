require 'buildsystems/pip'

class Py3_beautifulsoup4 < Pip
  description 'BeautifulSoup is a screen-scraping library.'
  homepage 'https://www.crummy.com/software/BeautifulSoup/'
  version "4.14.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd01db93acfef66f9fe3930c271cfd21f74aa55415df36315eba7b766c694bf1',
     armv7l: 'dd01db93acfef66f9fe3930c271cfd21f74aa55415df36315eba7b766c694bf1',
       i686: '93edfca0df68e4103dd1a99d58b48679e8af7251388ab97e7b6ddea0a3515ac1',
     x86_64: '6b62b9cfa936326150b38fd151cee4fc7f1e346bd2adc5f0c6db93d93c6f28fe'
  })

  depends_on 'py3_hatchling' => :build
  depends_on 'py3_soupsieve'
  depends_on 'python3' => :build

  no_source_build
end
