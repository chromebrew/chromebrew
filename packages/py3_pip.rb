require 'package'

class Py3_pip < Package
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  @_ver = '21.3.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.3.1_armv7l/py3_pip-21.3.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.3.1_armv7l/py3_pip-21.3.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.3.1_i686/py3_pip-21.3.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.3.1_x86_64/py3_pip-21.3.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0aaabc8b36b049243e2c7532c5c2744ad433977a930c86544f9a1482de83ef6c',
     armv7l: '0aaabc8b36b049243e2c7532c5c2744ad433977a930c86544f9a1482de83ef6c',
       i686: '12bda5895cedab8e41e9bb110a73f654230d04ad3abc55006e46e06158725fa0',
     x86_64: 'f54f266e6727c2a480eb565b2e1ee2f1cf7b7c28db8d0d1330b27b8291086e7d'
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
