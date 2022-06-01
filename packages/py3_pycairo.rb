require 'package'

class Py3_pycairo < Package
  description 'Pycairo is a provides bindings for the cairo graphics library.'
  homepage 'https://cairographics.org/pycairo/'
  @_ver = '1.20.1'
  version @_ver
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/pygobject/pycairo.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.20.1_armv7l/py3_pycairo-1.20.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.20.1_armv7l/py3_pycairo-1.20.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.20.1_i686/py3_pycairo-1.20.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.20.1_x86_64/py3_pycairo-1.20.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '89bb391cdd02287f7f22bea97b93b3fc839a1894d0de10463a39e45de6cdd785',
     armv7l: '89bb391cdd02287f7f22bea97b93b3fc839a1894d0de10463a39e45de6cdd785',
       i686: 'fc49b20882389682515c5658c6152c171e24c16a8b822e8be92448a8167e3d1c',
     x86_64: 'bdedb23f949e4bdcea77d3a1018d26bb1492b4498f383e6fc704e697b648e579'
  })

  depends_on 'cairo'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
