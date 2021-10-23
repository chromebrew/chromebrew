require 'package'

class Py3_idna < Package
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  @_ver = '3.3'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/kjd/idna.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.3_armv7l/py3_idna-3.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.3_armv7l/py3_idna-3.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.3_i686/py3_idna-3.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.3_x86_64/py3_idna-3.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '71c5bcfd6b47d99e09fc5b9e059646640c6f35620cab0e7a93383f9bc82d3430',
     armv7l: '71c5bcfd6b47d99e09fc5b9e059646640c6f35620cab0e7a93383f9bc82d3430',
       i686: '5985ea0c4181edc690e61903e2790cd40d99e46394ba572606a4b05670206308',
     x86_64: 'fe7f87938728d1c94718ff5844f8e33f137d032e3303dc469fa4825f85419b0b'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
