require 'package'

class Py3_greenlet < Package
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  @_ver = '1.1.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python-greenlet/greenlet.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/1.1.0_armv7l/py3_greenlet-1.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/1.1.0_armv7l/py3_greenlet-1.1.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/1.1.0_x86_64/py3_greenlet-1.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f5c1a3532b05917a888490359d5d63fa852781be3987f5f682e378e74bf6dae7',
     armv7l: 'f5c1a3532b05917a888490359d5d63fa852781be3987f5f682e378e74bf6dae7',
     x86_64: '05d6bfaa4de933989cddbea9a604d5b8930a19df365a56479d21cfb5e0732426'
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
