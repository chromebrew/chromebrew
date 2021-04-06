require 'package'

class Py3_configparser < Package
  description 'Configparser backports a refreshed and enhanced ConfigParser module from later python versions.'
  homepage 'https://github.com/jaraco/configparser/'
  version '5.0.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/c9/9c/c1ac39b3c72a70e93479cb4b7f1123f693293c5e4c40fdb3e1242f740665/configparser-5.0.2.tar.gz'
  source_sha256 '85d5de102cfe6d14a5172676f09d19c465ce63d6019cf0a4ef13385fc535e828'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
