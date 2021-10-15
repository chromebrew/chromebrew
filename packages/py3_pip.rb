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
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/21.3_x86_64/py3_pip-21.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2cbadf25b7a92858b4f0b31680c0936b4e760fe2be0f7bf2ebdb6d8b615841d6',
     armv7l: '2cbadf25b7a92858b4f0b31680c0936b4e760fe2be0f7bf2ebdb6d8b615841d6',
     x86_64: 'c2262af02126182189df0a77e8de9ba3021718d1c2339f84f198e36d83295dc4'
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
