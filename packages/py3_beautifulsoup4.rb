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
    aarch64: 'f2b740ce4c91de5f3a48da9bd590e053819d33546ab8a9364a299ec8a50cd030',
     armv7l: 'f2b740ce4c91de5f3a48da9bd590e053819d33546ab8a9364a299ec8a50cd030',
       i686: '93edfca0df68e4103dd1a99d58b48679e8af7251388ab97e7b6ddea0a3515ac1',
     x86_64: '2b654cdeab64ba946129a03b0b5ddad0f013cec397e07fdf19e5ac9e24db207e'
  })

  depends_on 'py3_hatchling' => :build
  depends_on 'py3_soupsieve'
  depends_on 'python3' => :build

  no_source_build
end
