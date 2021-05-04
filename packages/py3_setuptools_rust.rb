require 'package'

class Py3_setuptools_rust < Package
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust/'
  @_ver = '0.12.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/setuptools-rust.git'
  git_hashtag 'v' + @_ver

  depends_on 'rust'
  depends_on 'py3_toml'
  depends_on 'py3_semantic_version'
  depends_on 'py3_setuptools'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
