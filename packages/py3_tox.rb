require 'package'

class Py3_tox < Package
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  @_ver = '3.24.4'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tox-dev/tox.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.24.4-py3.11_armv7l/py3_tox-3.24.4-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.24.4-py3.11_armv7l/py3_tox-3.24.4-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.24.4-py3.11_i686/py3_tox-3.24.4-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tox/3.24.4-py3.11_x86_64/py3_tox-3.24.4-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5ba9a21d6645967b3a7e726b3834f25c587387e71ba927e5d528aca87bea6fb1',
     armv7l: '5ba9a21d6645967b3a7e726b3834f25c587387e71ba927e5d528aca87bea6fb1',
       i686: 'ba654fd29432283c58d5cad02f1d0edbf87b151acc646f4659b337c237cb7ce0',
     x86_64: 'ebb138ef196a952b3c1c806170bffc11ac006fb0c88939628f19b4be921548d4'
  })

  depends_on 'py3_py'
  depends_on 'py3_filelock'
  depends_on 'py3_six'
  depends_on 'py3_packaging'
  depends_on 'py3_virtualenv'
  depends_on 'py3_pluggy'
  depends_on 'py3_toml'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
