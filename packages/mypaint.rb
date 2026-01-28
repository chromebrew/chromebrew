require 'package'

class Mypaint < Package
  description 'MyPaint is a simple drawing and painting program.'
  homepage 'https://mypaint.app/'
  @_ver = '2.0.1'
  version "#{@_ver}-1"
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/mypaint/mypaint.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '65b8fcea7a9864553887c42490bdc1743a7bbb55f5e84766b805423d10912ef0',
     armv7l: '65b8fcea7a9864553887c42490bdc1743a7bbb55f5e84766b805423d10912ef0',
       i686: '033e80ce9b49bff9a25200a3e3d20204d388cd0b98cb5164a65debb0591d8624',
     x86_64: 'e5145a805c4748821e181e15347d55ac2d4d98b0ae95a146b121f06790f62768'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'json_c' # R
  depends_on 'lcms' # R
  depends_on 'libpng' # R
  depends_on 'librsvg'
  depends_on 'mypaint_brushes'
  depends_on 'openmp'
  depends_on 'pango' # R
  depends_on 'py3_numpy'
  depends_on 'py3_pygobject'
  depends_on 'python3' => :build
  depends_on 'sommelier' => :logical
  depends_on 'swig' => :build
  depends_on 'xdg_base'
  depends_on 'zlib' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
