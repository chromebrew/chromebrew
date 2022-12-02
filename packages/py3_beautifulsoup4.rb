require 'package'

class Py3_beautifulsoup4 < Package
  description 'BeautifulSoup is a screen-scraping library.'
  homepage 'https://www.crummy.com/software/BeautifulSoup/'
  @_ver = '4.10.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/a1/69/daeee6d8f22c997e522cdbeb59641c4d31ab120aba0f2c799500f7456b7e/beautifulsoup4-4.10.0.tar.gz'
  source_sha256 'c23ad23c521d818955a4151a67d81580319d4bf548d3d49f4223ae041ff98891'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.10.0-py3.11_armv7l/py3_beautifulsoup4-4.10.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.10.0-py3.11_armv7l/py3_beautifulsoup4-4.10.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.10.0-py3.11_i686/py3_beautifulsoup4-4.10.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.10.0-py3.11_x86_64/py3_beautifulsoup4-4.10.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '62a34982a10d2974afc5779d544b0204764812b2ade2166ebd28fbeab6a633c8',
     armv7l: '62a34982a10d2974afc5779d544b0204764812b2ade2166ebd28fbeab6a633c8',
       i686: '71f70caddc5c48b8a9a590b96905da9854d7ec8bba2cdae9e26a6199882a8e08',
     x86_64: '73396f0ec6e75dafe95fc072aa3ba62e83eac708df0a71349d51848179fb8c8d'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
