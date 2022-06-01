require 'package'

class Py3_beautifulsoup4 < Package
  description 'BeautifulSoup is a screen-scraping library.'
  homepage 'https://www.crummy.com/software/BeautifulSoup/'
  @_ver = '4.10.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/a1/69/daeee6d8f22c997e522cdbeb59641c4d31ab120aba0f2c799500f7456b7e/beautifulsoup4-4.10.0.tar.gz'
  source_sha256 'c23ad23c521d818955a4151a67d81580319d4bf548d3d49f4223ae041ff98891'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.10.0_armv7l/py3_beautifulsoup4-4.10.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.10.0_armv7l/py3_beautifulsoup4-4.10.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.10.0_i686/py3_beautifulsoup4-4.10.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_beautifulsoup4/4.10.0_x86_64/py3_beautifulsoup4-4.10.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd4908aaf4b2390f022f9e5539da7aca032b1def7766f9614d031878224384fc0',
     armv7l: 'd4908aaf4b2390f022f9e5539da7aca032b1def7766f9614d031878224384fc0',
       i686: '6c2a717d0ee6504327e63298dbab27fa19870921c3717d4587a5a09c5c18ef00',
     x86_64: '8f5e478b22f881e316b81fa15b7347d75406cb03eac2e4894f83640c4090389b'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
