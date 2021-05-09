require 'package'

class Py3_secretstorage < Package
  description 'Jeepney is a low-level, pure Python DBus protocol wrapper.'
  homepage 'https://secretstorage.readthedocs.io/'
  @_ver = '3.3.1'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/mitya57/secretstorage.git'
  git_hashtag @_ver

  depends_on 'py3_jeepney'
  depends_on 'py3_cryptography'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
