require 'package'

class Py3_setuptools < Package
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  @_ver = '58.2.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/1e/5c/3d7b3d91a86d71faf5038c5d259ed36b5d05b7804648e2c43251d574a6e6/setuptools-58.2.0.tar.gz'
  source_sha256 '2c55bdb85d5bb460bd2e3b12052b677879cffcf46c0c688f2e5bf51d36001145'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/58.2.0_armv7l/py3_setuptools-58.2.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/58.2.0_armv7l/py3_setuptools-58.2.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/58.2.0_i686/py3_setuptools-58.2.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/58.2.0_x86_64/py3_setuptools-58.2.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5b6921438cf08e88cfa0d4fdecc61e5eb8140dab650fffd260549a50133f60da',
     armv7l: '5b6921438cf08e88cfa0d4fdecc61e5eb8140dab650fffd260549a50133f60da',
       i686: 'ce979469a5b1a5aedf3773eb698960dd98d92762e14fc0ec7ae780c587769bf5',
     x86_64: 'b8f4281610d8efd9796d37deed684a934101aa70bc6abf132fb930763a251202'
  })

  depends_on 'py3_packaging'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
