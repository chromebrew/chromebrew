require 'package'

class Py3_configparser < Package
  description 'Configparser backports newer configparser modules to earlier python versions.'
  homepage 'https://github.com/jaraco/configparser/'
  @_ver = '5.0.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jaraco/configparser.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
