require 'package'

class Py3_cssselect < Package
  description 'CSSselect parses CSS3 Selectors and translates them to XPath 1.0.'
  homepage 'https://cssselect.readthedocs.io/'
  @_ver = '1.1.0'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/scrapy/cssselect.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0-1_armv7l/py3_cssselect-1.1.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0-1_armv7l/py3_cssselect-1.1.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0-1_i686/py3_cssselect-1.1.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0-1_x86_64/py3_cssselect-1.1.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7119884c145fa8377a85c046227b1303fc96b494c96b788c6ef7690e5dd50dac',
     armv7l: '7119884c145fa8377a85c046227b1303fc96b494c96b788c6ef7690e5dd50dac',
       i686: 'dacbdc4729a1479f95b4a7fba2d5a5215904d7239e6d6473ada98e40b845026b',
     x86_64: '32f4c061ade50ca3d27c10908770cd2a93ca8b995e20473911da11d912e60f03'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
