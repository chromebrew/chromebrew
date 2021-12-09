require 'package'

class Py3_pyudev < Package
  description 'Pyudev provides Python bindings for udev.'
  homepage 'https://pyudev.readthedocs.io/'
  @_ver = '0.22'
  version "#{@_ver}-1"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/pyudev/pyudev.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22-1_armv7l/py3_pyudev-0.22-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22-1_armv7l/py3_pyudev-0.22-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22-1_i686/py3_pyudev-0.22-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyudev/0.22-1_x86_64/py3_pyudev-0.22-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6f96581d66c5d51baa0544e223a93e96a9eb4621756bf1af2da9be4e9429354c',
     armv7l: '6f96581d66c5d51baa0544e223a93e96a9eb4621756bf1af2da9be4e9429354c',
       i686: '864fefb8d20b6f04a651d3f02aac3920fa3a0a9358cb7ab98a0c491d4fadd7c0',
     x86_64: '40f85661d9dbfac8a0f9a356b346b86ab9251af10821f24b72fd831b95da7cc6'
  })

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
