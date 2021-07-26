require 'package'

class Py3_urllib3 < Package
  description 'URLlib3 is an HTTP library with thread-safe connection pooling, file post, and more.'
  homepage 'https://urllib3.readthedocs.io/'
  @_ver = '1.26.4'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/urllib3/urllib3.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.4_armv7l/py3_urllib3-1.26.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.4_armv7l/py3_urllib3-1.26.4-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urllib3/1.26.4_x86_64/py3_urllib3-1.26.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'bf68c09e43c2146279fef1aebc82391a3a00f84d02bd8c1886583f84a92ae8d8',
     armv7l: 'bf68c09e43c2146279fef1aebc82391a3a00f84d02bd8c1886583f84a92ae8d8',
     x86_64: '0f4f87c1ca55ada88d565c947a3219502baa207396a4cdce27873f9126cab279'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
