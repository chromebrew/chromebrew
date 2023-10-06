require 'buildsystems/pip'

class Py3_beautifulsoup4 < Pip
  description 'BeautifulSoup is a screen-scraping library.'
  homepage 'https://www.crummy.com/software/BeautifulSoup/'
  @_ver = '4.12.2'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_hatchling' => :build
  depends_on 'py3_soupsieve'
  depends_on 'python3' => :build

  no_compile_needed
end
