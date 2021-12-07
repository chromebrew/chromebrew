require 'package'

class Py3_abimap < Package
  description 'A helper for library maintainers to use symbol versioning'
  homepage 'https://github.com/ansasaki/abimap'
  @_ver = '0.3.2'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ansasaki/abimap.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2_armv7l/py3_abimap-0.3.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2_armv7l/py3_abimap-0.3.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2_i686/py3_abimap-0.3.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2_x86_64/py3_abimap-0.3.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '17960fb4f2c9073fea232c4835e34e5349af64f1915da2aa635a34da9b6dde43',
     armv7l: '17960fb4f2c9073fea232c4835e34e5349af64f1915da2aa635a34da9b6dde43',
       i686: 'dfab6cd967ab37101a8d2004fa3c439208e6e2107f255fc68fc161b12348f05e',
     x86_64: 'bba37f252802900965d428a645a906413c4bf212de296343e2de9a4e7beacec8'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
