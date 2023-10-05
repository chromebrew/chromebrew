require 'buildsystems/pip'

class Py3_beautifulsoup4 < Pip
  description 'BeautifulSoup is a screen-scraping library.'
  homepage 'https://www.crummy.com/software/BeautifulSoup/'
  @_ver = '4.12.2'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.12.2-py3.12_armv7l/py3_beautifulsoup4-4.12.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.12.2-py3.12_armv7l/py3_beautifulsoup4-4.12.2-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.12.2-py3.12_i686/py3_beautifulsoup4-4.12.2-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.12.2-py3.12_x86_64/py3_beautifulsoup4-4.12.2-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '074a9e524c611a8059e3423d0cd300d74b6e5b0e946e22412476df5dfba3a9f7',
     armv7l: '074a9e524c611a8059e3423d0cd300d74b6e5b0e946e22412476df5dfba3a9f7',
       i686: 'de7380a442466366c0cdf41ffc96aa0a43d76be9176e86ce36aaf2c79b0ece86',
     x86_64: '36f145ae5d1bc795f95f72ce94f1404b662f2e5bd64daf51f2c60f6b8d064369'
  })

  depends_on 'python3' => :build
  depends_on 'py3_hatchling' => :build
  depends_on 'py3_soupsieve'
end
