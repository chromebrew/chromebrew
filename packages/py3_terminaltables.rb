# NOTE: Archived upstream

require 'package'

class Py3_terminaltables < Package
  description 'Terminaltables generates simple tables in terminals from a nested list of strings.'
  homepage 'https://robpol86.github.io/terminaltables/'
  @_ver = '3.1.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Robpol86/terminaltables.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0-1_armv7l/py3_terminaltables-3.1.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0-1_armv7l/py3_terminaltables-3.1.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0-1_i686/py3_terminaltables-3.1.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_terminaltables/3.1.0-1_x86_64/py3_terminaltables-3.1.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2afb651c18177ed003d1bf874cb590b8ed810227bab315d739308d2fd66d44bd',
     armv7l: '2afb651c18177ed003d1bf874cb590b8ed810227bab315d739308d2fd66d44bd',
       i686: '08b60be304384feef2e2442fd5f88fb33f2d7214420f5fc2c88d16664d1fdb2c',
     x86_64: '335535f87143e43e6ee5133287b73ac2aa0f47a10cc536e3ab47ee5e8150fa3f'
  })

  depends_on 'py3_dateutil'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
