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
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.20.1_x86_64/py3_pycairo-1.20.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '826fe011a1613ab0d40a00bb97b9cd900b3fad2112db76e0e0ab59307176a4ec',
     armv7l: '826fe011a1613ab0d40a00bb97b9cd900b3fad2112db76e0e0ab59307176a4ec',
     x86_64: '99346236c668f51cb077c5e9a49388bdf54860fb144590dfffdedef6c1710498'
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
