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
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/1.1.2_i686/py3_greenlet-1.1.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/1.1.2_x86_64/py3_greenlet-1.1.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3973fdaf733d14da300d17980880183c45d8d6d4110d03e15f02c97a1f4caf6a',
     armv7l: '3973fdaf733d14da300d17980880183c45d8d6d4110d03e15f02c97a1f4caf6a',
       i686: 'b57cb7c1a90bb5819fdfaefb8cda5a8e2c1edeb0a24a1665f8b5cd832090ae60',
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
