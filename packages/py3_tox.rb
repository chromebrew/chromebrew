require 'package'

class Py3_tox < Package
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  @_ver = '3.24.4'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tox-dev/tox.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.24.4_armv7l/py3_tox-3.24.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.24.4_armv7l/py3_tox-3.24.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.24.4_i686/py3_tox-3.24.4-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.24.4_x86_64/py3_tox-3.24.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '48b18633490b76fca8dbef6428ea3b95f8d84a1847517b3bc924c0302b0c5139',
     armv7l: '48b18633490b76fca8dbef6428ea3b95f8d84a1847517b3bc924c0302b0c5139',
       i686: 'ffeea5e8ee192ff7b32a8f899fd6b643770fb13011a3a1f15bec01c10e365846',
     x86_64: '1c3aaed8fd7000a5bc719855947eb75a556b81d2a023d3e8c3980cff4554df31'
  })

  depends_on 'py3_py'
  depends_on 'py3_filelock'
  depends_on 'py3_six'
  depends_on 'py3_packaging'
  depends_on 'py3_virtualenv'
  depends_on 'py3_pluggy'
  depends_on 'py3_toml'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
