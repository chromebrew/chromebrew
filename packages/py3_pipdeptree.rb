require 'package'

class Py3_pipdeptree < Package
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  @_ver = '2.2.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/naiquevin/pipdeptree.git'
  git_hashtag @_ver

  depends_on 'py3_pip'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
