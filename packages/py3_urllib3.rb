require 'package'

class Py3_urllib3 < Package
  description 'URLlib3 is an HTTP library with thread-safe connection pooling, file post, and more.'
  homepage 'https://urllib3.readthedocs.io/'
  @_ver = '1.26.7'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/urllib3/urllib3.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.7_armv7l/py3_urllib3-1.26.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.7_armv7l/py3_urllib3-1.26.7-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.7_i686/py3_urllib3-1.26.7-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.7_x86_64/py3_urllib3-1.26.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'dbd5ca53c39fb911ad6ae33ad032282138d5f8994253b441a0978dabcfcfdf18',
     armv7l: 'dbd5ca53c39fb911ad6ae33ad032282138d5f8994253b441a0978dabcfcfdf18',
       i686: '0fb08f895c6ece13c188910c85fb3b6d2db8bbc7e7c89d269f2ba8985fd30ac2',
     x86_64: 'c0e94dff22ba0d556ee4fcae20e8eee0817e2f083219429aa7b44127d6996ffe'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
