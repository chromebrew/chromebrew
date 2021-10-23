require 'package'

class Py3_lxml < Package
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  @_ver = '4.6.3'
  version "#{@_ver}-1"
  license 'BSD-3'
  # source_url 'https://github.com/lxml/lxml.git'
  # git_hashtag "lxml-#{@_ver}"
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/e5/21/a2e4517e3d216f0051687eea3d3317557bde68736f038a3b105ac3809247/lxml-4.6.3.tar.gz'
  source_sha256 '39b78571b3b30645ac77b95f7c69d1bffc4cf8c3b157c435a34da72e78c82468'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_lxml/4.6.3-1_armv7l/py3_lxml-4.6.3-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_lxml/4.6.3-1_armv7l/py3_lxml-4.6.3-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_lxml/4.6.3-1_i686/py3_lxml-4.6.3-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_lxml/4.6.3-1_x86_64/py3_lxml-4.6.3-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5a6f4d0843e9b6502c74935202bd2726697e3fa05c666f8c030108575e5c3d0e',
     armv7l: '5a6f4d0843e9b6502c74935202bd2726697e3fa05c666f8c030108575e5c3d0e',
       i686: '23eb5d1bc3944c3b4def3cda2a6eace9f7f8dc1b2c7b6a0d167601e03511ad7e',
     x86_64: '88675cdd305b744f305828cf3238b5690ca7a92cf6e69a96ca8184200d7ed459'
  })

  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
