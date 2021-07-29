require 'package'

class Mypaint < Package
  description 'MyPaint is a simple drawing and painting program.'
  homepage 'http://mypaint.org/'
  @_ver = '2.0.1'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/mypaint/mypaint.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint/2.0.1_armv7l/mypaint-2.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint/2.0.1_armv7l/mypaint-2.0.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mypaint/2.0.1_x86_64/mypaint-2.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd97f73215a501086af09156b0393aa9f2337a9baa102b6980d104b562943f460',
     armv7l: 'd97f73215a501086af09156b0393aa9f2337a9baa102b6980d104b562943f460',
     x86_64: '4e5718aa6dc82c95dbd6e264a28021d3900b046d70d351a8ce591c07b5bff684'
  })

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
