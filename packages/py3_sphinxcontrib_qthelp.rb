require 'package'

class Py3_sphinxcontrib_qthelp < Package
  description 'sphinxcontrib-qthelp is a sphinx extension which outputs QtHelp document.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.3'
  version @_ver + '-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-qthelp.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
