require 'package'

class Py3_pycairo < Package
  description 'Pycairo is a provides bindings for the cairo graphics library.'
  homepage 'https://cairographics.org/pycairo/'
  @_ver = '1.20.0'
  version @_ver
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/pygobject/pycairo.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.20.0_armv7l/py3_pycairo-1.20.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.20.0_armv7l/py3_pycairo-1.20.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.20.0_i686/py3_pycairo-1.20.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.20.0_x86_64/py3_pycairo-1.20.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '845603cc75602939a723553988c809dd33a6d8993385384f2be639625844cf2f',
     armv7l: '845603cc75602939a723553988c809dd33a6d8993385384f2be639625844cf2f',
       i686: '41a7a6dd34f3add72b663965f178a64f6a4b254740dde9d5fdf08afea3f827d5',
     x86_64: '8b422b09d245634bf5257c408ccf78245c0d9555627800882f4856a30bf03d81'
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
