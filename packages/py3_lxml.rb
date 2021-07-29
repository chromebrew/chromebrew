require 'package'

class Py3_lxml < Package
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  @_ver = '4.6.3'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/lxml/lxml.git'
  git_hashtag "lxml-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_lxml/4.6.3_armv7l/py3_lxml-4.6.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_lxml/4.6.3_armv7l/py3_lxml-4.6.3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_lxml/4.6.3_x86_64/py3_lxml-4.6.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '78988749162202d2da062a5c9b718d27f9cb0290d18cf3526eeba8affa489657',
     armv7l: '78988749162202d2da062a5c9b718d27f9cb0290d18cf3526eeba8affa489657',
     x86_64: 'fa0232ee0bd1d4a171f37f15e0e608e3fd27bc9306c30d195ac83639cfa5feb6'
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
