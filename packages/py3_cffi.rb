require 'package'

class Py3_cffi < Package
  description 'C Foreign Function Interface for Python calling C code.'
  homepage 'https://cffi.readthedocs.io/'
  @_ver = '1.15.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/00/9e/92de7e1217ccc3d5f352ba21e52398372525765b2e0c4530e6eb2ba9282a/cffi-1.15.0.tar.gz'
  source_sha256 '920f0d66a896c2d99f0adbb391f990a84091179542c205fa53ce5787aff87954'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.0-py3.11_armv7l/py3_cffi-1.15.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.0-py3.11_armv7l/py3_cffi-1.15.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.0-py3.11_i686/py3_cffi-1.15.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.0-py3.11_x86_64/py3_cffi-1.15.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ed06675b88a4cdb3a722e7fda48a646b1afea39cf2bb79adeff1bc7d9d5646b9',
     armv7l: 'ed06675b88a4cdb3a722e7fda48a646b1afea39cf2bb79adeff1bc7d9d5646b9',
       i686: '681ae7959a6cc57d64b36a3114bde7884034487dd41b144c96d461906502bf92',
     x86_64: 'dbd694a4d23264d95be5ddcd14f64dc88977e1cc6d6f3be3023383fdfafaf585'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R
  depends_on 'libffi' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
