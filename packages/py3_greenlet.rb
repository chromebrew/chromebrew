require 'package'

class Py3_greenlet < Package
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  @_ver = '1.1.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python-greenlet/greenlet.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/1.1.2_armv7l/py3_greenlet-1.1.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/1.1.2_armv7l/py3_greenlet-1.1.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/1.1.2_x86_64/py3_greenlet-1.1.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '74d2f75fce417fdcf5f0c38cfd4e99b6ba3e27378b6f24df86cdac0c3d364fb5',
     armv7l: '74d2f75fce417fdcf5f0c38cfd4e99b6ba3e27378b6f24df86cdac0c3d364fb5',
     x86_64: '4717465c5a34afac6d33fb97ed713290e199a067f01ec0bc4ce4e52a6a86708b'
  })

  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
