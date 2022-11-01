require 'package'

class Py3_pycairo < Package
  description 'Pycairo is a provides bindings for the cairo graphics library.'
  homepage 'https://cairographics.org/pycairo/'
  @_ver = '1.21.0'
  version "#{@_ver}-py3.11"
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/pygobject/pycairo.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.21.0_armv7l/py3_pycairo-1.21.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.21.0_armv7l/py3_pycairo-1.21.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.21.0_i686/py3_pycairo-1.21.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.21.0_x86_64/py3_pycairo-1.21.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '45cf8d42a2c468f4d273e30151b5d3ec78c46dd28e4bfceeb3bd03cbb2ff4e4a',
     armv7l: '45cf8d42a2c468f4d273e30151b5d3ec78c46dd28e4bfceeb3bd03cbb2ff4e4a',
       i686: '321d224a6570c792700820ff8d1ce538133dc0dd0e0ba5fd496b5b4bd80bed00',
     x86_64: 'f37231b8e0e5054f989b85b39b529eb87672cb44f6757964a2c633d14b7a5bc1'
  })

  depends_on 'cairo'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'
  depends_on 'py3_setuptools' => :build
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
