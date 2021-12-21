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
    aarch64: 'd91bf1ade1511d8cb42c5659775d9841783c926c745ede579c47d1ba6ce469cc',
     armv7l: 'd91bf1ade1511d8cb42c5659775d9841783c926c745ede579c47d1ba6ce469cc',
       i686: '5d4506684187bf337b98e79fcee280b83b8415e6f818cd614cb7cedd1126d787',
     x86_64: 'b9877ea3ee581f3a9d5321a4fdc70ee6484dce21e11962ce77dcab5d0736be08'
  })

  depends_on 'py3_packaging'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
