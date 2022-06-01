require 'package'

class Py3_idna < Package
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  @_ver = '3.3'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/kjd/idna.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.3_armv7l/py3_idna-3.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.3_armv7l/py3_idna-3.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.3_i686/py3_idna-3.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.3_x86_64/py3_idna-3.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ed49da638b58f74acdc60d42a773c185e91b70f530d19eb11e9af4167b5e2471',
     armv7l: 'ed49da638b58f74acdc60d42a773c185e91b70f530d19eb11e9af4167b5e2471',
       i686: '6d7894d08a495d2d47eb06acb6c6a793b3fed4613e6dba9f8a93712958671774',
     x86_64: '1d3b86b227ccd09abea28ea7848a22c2a3af641bc4626e648095b6ca6d12d4a7'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
