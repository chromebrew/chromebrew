require 'package'

class Py3_pystemmer < Package
  description 'Snowball stemming algorithms, for information retrieval'
  homepage 'http://snowball.tartarus.org'
  @_ver = '2.0.1'
  version "#{@_ver}-1"
  license 'BSD MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/55/b2/c3aeebfe4a60256ddb72257e750a94c26c3085f017b7e58c860d5aa91432/PyStemmer-2.0.1.tar.gz'
  source_sha256 '9b81c35302f1d2a5ad9465b85986db246990db93d97d3e8f129269ed7102788e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pystemmer/2.0.1-1_armv7l/py3_pystemmer-2.0.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pystemmer/2.0.1-1_armv7l/py3_pystemmer-2.0.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pystemmer/2.0.1-1_i686/py3_pystemmer-2.0.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pystemmer/2.0.1-1_x86_64/py3_pystemmer-2.0.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0b610bade3fb21af4c4e91a90efaba597b69ec971a9a6d4576524c55d13eae2a',
     armv7l: '0b610bade3fb21af4c4e91a90efaba597b69ec971a9a6d4576524c55d13eae2a',
       i686: '91e68d685ba077a393abd83d33c2f5bb6f55867c483941a53a8a354031f0f1d7',
     x86_64: '1eb6687f4f01a3d9dd1436570789bc2f3de1f257939b39a5a12b706c418f6852'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
