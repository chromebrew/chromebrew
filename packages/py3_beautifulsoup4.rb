require 'package'

class Py3_beautifulsoup4 < Package
  description 'BeautifulSoup is a screen-scraping library.'
  homepage 'https://www.crummy.com/software/BeautifulSoup/'
  @_ver = '4.9.3'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/6b/c3/d31704ae558dcca862e4ee8e8388f357af6c9d9acb0cad4ba0fbbd350d9a/beautifulsoup4-4.9.3.tar.gz'
  source_sha256 '84729e322ad1d5b4d25f805bfa05b902dd96450f43842c4e99067d5e1369eb25'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.9.3_armv7l/py3_beautifulsoup4-4.9.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.9.3_armv7l/py3_beautifulsoup4-4.9.3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.9.3_x86_64/py3_beautifulsoup4-4.9.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5d32a945ceffa8d39198bba8ebfd3830b1298eccd913134b11f8161d5ffdd102',
     armv7l: '5d32a945ceffa8d39198bba8ebfd3830b1298eccd913134b11f8161d5ffdd102',
     x86_64: 'b4de5da35e8c1a64fce5375c6c61917d69763ec3f8afd0383690d2ca9638b424'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
