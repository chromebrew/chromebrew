require 'package'

class Py3_sphinxcontrib_jsmath < Package
  description 'sphinxcontrib-jsmath is a sphinx extension which renders display math in HTML via JavaScript.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.1'
  version @_ver + '-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-jsmath.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
