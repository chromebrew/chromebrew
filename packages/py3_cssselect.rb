require 'package'

class Py3_cssselect < Package
  description 'CSSselect parses CSS3 Selectors and translates them to XPath 1.0.'
  homepage 'https://cssselect.readthedocs.io/'
  @_ver = '1.1.0'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/scrapy/cssselect.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0_armv7l/py3_cssselect-1.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0_armv7l/py3_cssselect-1.1.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cssselect/1.1.0_x86_64/py3_cssselect-1.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'daadd3f8649cabb1884f2e8ed37c05149be271e3aff9d0022548ce896a11e5ab',
     armv7l: 'daadd3f8649cabb1884f2e8ed37c05149be271e3aff9d0022548ce896a11e5ab',
     x86_64: 'bb1c01edf7595c0fdd4baa7c738df7c7c4c861f7b64bf1a23e2fc908d1d3f341'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
