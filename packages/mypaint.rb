require 'package'

class Mypaint < Package
  description 'MyPaint is a simple drawing and painting program.'
  homepage 'http://mypaint.org/'
  @_ver = '2.0.1'
  version "#{@_ver}-1"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/mypaint/mypaint.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint/2.0.1-1_armv7l/mypaint-2.0.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint/2.0.1-1_armv7l/mypaint-2.0.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint/2.0.1-1_i686/mypaint-2.0.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint/2.0.1-1_x86_64/mypaint-2.0.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '65b8fcea7a9864553887c42490bdc1743a7bbb55f5e84766b805423d10912ef0',
     armv7l: '65b8fcea7a9864553887c42490bdc1743a7bbb55f5e84766b805423d10912ef0',
       i686: '033e80ce9b49bff9a25200a3e3d20204d388cd0b98cb5164a65debb0591d8624',
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
