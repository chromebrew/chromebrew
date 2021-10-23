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
    aarch64: 'e47348d9a6d241c38debce01b30edab5f71230f258a0649ff3d023db805e81ab',
     armv7l: 'e47348d9a6d241c38debce01b30edab5f71230f258a0649ff3d023db805e81ab',
       i686: '157cbc9504f1560bf5bc7c022bccd8f74fbce9ce6acb70eb0e7969ff788c8952',
     x86_64: '0d5023a007eeba2c483febb8e790cbe354085789122afda65b1c24ec86ae6a68'
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
