require 'package'

class Mypaint < Package
  description 'MyPaint is a simple drawing and painting program.'
  homepage 'http://mypaint.org/'
  @_ver = '2.0.1'
  version @_ver + '-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/mypaint/mypaint.git'
  git_hashtag "v#{@_ver}"

  depends_on 'swig' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'mypaint_brushes'
  depends_on 'pygobject'
  depends_on 'librsvg'
  depends_on 'xdg_base'
  depends_on 'sommelier'
  depends_on 'py3_numpy'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
