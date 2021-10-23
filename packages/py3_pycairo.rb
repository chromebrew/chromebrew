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
    aarch64: '4ec3c476ae325d46812a4174b20adf344d61487ef53e4bfae3e8f7ab324a41ce',
     armv7l: '4ec3c476ae325d46812a4174b20adf344d61487ef53e4bfae3e8f7ab324a41ce',
       i686: '9aefbedc80f65dc265ebcf9c04867e2b8efa87622f11d6af85f1c1fce0296554',
     x86_64: '12baa4a5e9f92a6dacd349302b32fd22e563d5d74b71521d5e8e49820c7a54e3'
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
