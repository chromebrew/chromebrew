require 'package'

class Py3_ebooklib < Package
  description 'Ebooklib is a Python E-book library for handling books in EPUB2/EPUB3 format.'
  homepage 'https://docs.sourcefabric.org/projects/ebooklib/'
  @_ver = '0.17.1'
  version @_ver + '-1'
  license 'AGPL-3'
  compatibility 'all'
  source_url 'https://github.com/aerkalov/ebooklib.git'
  git_hashtag "v#{@_ver}"

  depends_on 'py3_lxml'
  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
