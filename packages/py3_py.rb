require 'package'

class Py3_py < Package
  description 'Py is a library with cross-python path, ini-parsing, io, code, log facilities.'
  homepage 'https://py.readthedocs.io/'
  @_ver = '1.10.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/py.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.10.0_armv7l/py3_py-1.10.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.10.0_armv7l/py3_py-1.10.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.10.0_i686/py3_py-1.10.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.10.0_x86_64/py3_py-1.10.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e9ced82384f0467de4f7ad23d91a4e96269e5e028dd2b070f7879c43ca96c048',
     armv7l: 'e9ced82384f0467de4f7ad23d91a4e96269e5e028dd2b070f7879c43ca96c048',
       i686: '7c02bec8c5074be46a42af64097bf356b0bbbb1763d4e575576e5af25959f191',
     x86_64: '0720c587e0acdefd21a73d5525d441f36b1ba2a4afcb6b7c8a2c16c8df63e522'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
