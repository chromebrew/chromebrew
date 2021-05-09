require 'package'

class Py3_jeepney < Package
  description 'Jeepney is a low-level, pure Python DBus protocol wrapper.'
  homepage 'https://gitlab.com/takluyver/jeepney/'
  @_ver = '0.6'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.com/takluyver/jeepney.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
