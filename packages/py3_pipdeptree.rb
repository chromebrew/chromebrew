require 'package'

class Py3_pipdeptree < Package
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  @_ver = '2.2.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/naiquevin/pipdeptree.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pipdeptree/2.2.0_armv7l/py3_pipdeptree-2.2.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pipdeptree/2.2.0_armv7l/py3_pipdeptree-2.2.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pipdeptree/2.2.0_i686/py3_pipdeptree-2.2.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pipdeptree/2.2.0_x86_64/py3_pipdeptree-2.2.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '856c38a3fcff169b2c465b483ace2d1b3b10a47226c1940ca97ced481a5b46dc',
     armv7l: '856c38a3fcff169b2c465b483ace2d1b3b10a47226c1940ca97ced481a5b46dc',
       i686: 'af91dccf56f875437b2d5aa13149753bd749e0e59995570484c562e0c1750b65',
     x86_64: '35d03b61ea2450b84a251047d21b49d4ec3ba967c800675a10ce4c93e0389e60'
  })

  depends_on 'py3_pip'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
