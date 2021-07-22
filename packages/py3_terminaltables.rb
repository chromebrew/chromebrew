require 'package'

class Py3_terminaltables < Package
  description 'Terminaltables generates simple tables in terminals from a nested list of strings.'
  homepage 'https://robpol86.github.io/terminaltables/'
  @_ver = '3.1.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Robpol86/terminaltables.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_dateutil'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
