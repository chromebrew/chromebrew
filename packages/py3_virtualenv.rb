require 'package'

class Py3_virtualenv < Package
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  @_ver = '20.0.27'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/virtualenv.git'
  git_hashtag @_ver

  depends_on 'py3_appdirs'
  depends_on 'py3_distlib'
  depends_on 'py3_six'
  depends_on 'py3_pip'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
