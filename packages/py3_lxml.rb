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
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_lxml/4.6.3-1_x86_64/py3_lxml-4.6.3-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f2bca8546b632cd5d46f162c0b1ee1c6d484b2e3f85b043e164227214492fa6e',
     armv7l: 'f2bca8546b632cd5d46f162c0b1ee1c6d484b2e3f85b043e164227214492fa6e',
     x86_64: '8ebb5cfc0782ee41bc5691b567b77ccfcadc109db4e88af0006174e1d36e3a4e'
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
