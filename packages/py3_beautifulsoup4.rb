require 'buildsystems/pip'

class Py3_beautifulsoup4 < Pip
  description 'BeautifulSoup is a screen-scraping library.'
  homepage 'https://www.crummy.com/software/BeautifulSoup/'
  version "4.13.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '47cbe7a9359c7246cd540073086e871b6be8b821bab7432d123e4ba431d64cb7',
     armv7l: '47cbe7a9359c7246cd540073086e871b6be8b821bab7432d123e4ba431d64cb7',
       i686: '3498eb4d346c9868cb338fdfd7099091c999bddb4bac971cee8bdd131c973e63',
     x86_64: 'b3a208aab090a0a63a9ce815c9af85fc965a9255ca5519d9de64a96a00412e8d'
  })

  depends_on 'py3_hatchling' => :build
  depends_on 'py3_soupsieve'
  depends_on 'python3' => :build

  no_source_build
end
