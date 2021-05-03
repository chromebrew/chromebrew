require 'package'

class Py3_markdown < Package
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  @_ver = '3.3.4'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/Python-Markdown/markdown.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
