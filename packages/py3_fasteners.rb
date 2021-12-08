require 'package'

class Py3_fasteners < Package
  description 'Fasteners provides useful locks for python programs.'
  homepage 'https://github.com/harlowja/fasteners/'
  @_ver = '0.16.3'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/harlowja/fasteners.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.16.3_armv7l/py3_fasteners-0.16.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.16.3_armv7l/py3_fasteners-0.16.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.16.3_i686/py3_fasteners-0.16.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.16.3_x86_64/py3_fasteners-0.16.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '033b5d05bc4541d543eaad6059ee38995d6b362b680402ff4cee7fb396353fa1',
     armv7l: '033b5d05bc4541d543eaad6059ee38995d6b362b680402ff4cee7fb396353fa1',
       i686: '74098c301e35a47d933968851b006fa4ae1cf86aa71c9dc92a6af6427b9a26cd',
     x86_64: '98bfe6cd0c785de714d712d0f878334feb0356a5d55e18c4a6f81bd60268857e'
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
