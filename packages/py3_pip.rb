require 'package'

class Py3_pip < Package
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  @_ver = '21.1.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.1.1_armv7l/py3_pip-21.1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.1.1_armv7l/py3_pip-21.1.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.1.1_i686/py3_pip-21.1.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.1.1_x86_64/py3_pip-21.1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9762d97c11d232dda3a0009620793d93f6f073839deb5478178b39131ebc568f',
     armv7l: '9762d97c11d232dda3a0009620793d93f6f073839deb5478178b39131ebc568f',
       i686: '167a767129284e150af3953dcfcf35caab2f9552d383ad55041d511d49b72e58',
     x86_64: '794210d8b23bf7f3ecf2377eee166da6acc3e1cfaa8db7ddbff1b4ec29d60007'
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
