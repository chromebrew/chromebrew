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
    aarch64: '7b918678000f961b652f48954ea4793db22afca84c8f9277cdd416a6ca48d283',
     armv7l: '7b918678000f961b652f48954ea4793db22afca84c8f9277cdd416a6ca48d283',
       i686: '1ac7266fc93143810cf3a2061ed79908df19f376d1b9e64a06ae5cd0b43ded78',
     x86_64: '0df516ed964fb67a36d69028c256e0e085f506058b5d517287888c1cbd9cf527'
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
