require 'package'

class Py3_pip < Package
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  @_ver = '21.3'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.3_armv7l/py3_pip-21.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.3_armv7l/py3_pip-21.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.3_i686/py3_pip-21.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.3_x86_64/py3_pip-21.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a44ec70efafb7b9453df5fda31587b7a28e00796d0636ee832217a09ecb4a1c9',
     armv7l: 'a44ec70efafb7b9453df5fda31587b7a28e00796d0636ee832217a09ecb4a1c9',
       i686: '106006dbe2249d2e6f78f299e4ad1213169bfe2d4dad6ed9d6ecf36e8e63388c',
     x86_64: '61d0d35a1170a24a6a172abe2017442620856273123a5d01b57b11219356aef7'
  })

  depends_on 'python3'
  depends_on 'py3_setuptools'
  depends_on 'py3_wheel'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"

    # Make pip3 the default pip
    # FileUtils.ln_s "pip3", "#{CREW_DEST_PREFIX}/bin/pip" # This automatically happens
  end
end
