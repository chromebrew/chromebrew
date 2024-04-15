require 'package'

class Mypaint < Package
  description 'MyPaint is a simple drawing and painting program.'
  homepage 'http://mypaint.org/'
  @_ver = '2.0.1'
  version "#{@_ver}-1"
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/mypaint/mypaint.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '65b8fcea7a9864553887c42490bdc1743a7bbb55f5e84766b805423d10912ef0',
     armv7l: '65b8fcea7a9864553887c42490bdc1743a7bbb55f5e84766b805423d10912ef0',
     x86_64: 'e5145a805c4748821e181e15347d55ac2d4d98b0ae95a146b121f06790f62768'
  })

  depends_on 'swig' => :build
  depends_on 'python3' => :build
  depends_on 'mypaint_brushes'
  depends_on 'openmp'
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
