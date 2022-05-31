require 'package'

class Py3_installer < Package
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://installer.readthedocs.io/'
  @_ver = '0.5.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/installer.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1_armv7l/py3_installer-0.5.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1_armv7l/py3_installer-0.5.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1_i686/py3_installer-0.5.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1_x86_64/py3_installer-0.5.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5e74ca2aacdd953fd8d404394cd184a9c5fdab5b5cd9604285a1c0d60710d305',
     armv7l: '5e74ca2aacdd953fd8d404394cd184a9c5fdab5b5cd9604285a1c0d60710d305',
       i686: '2a7eb4c4e3fc39a9f36f50e3d0b30429cc16a327322f35b6a031b76aa10df811',
     x86_64: 'c4d852d89c1d5ebaa3dc92b96ad2645f4813a04e8982eca6bddcdf14ef90761b'
  })

  def self.build
    system "python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
