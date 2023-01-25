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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.21.0-py3.11_armv7l/py3_pycairo-1.21.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.21.0-py3.11_armv7l/py3_pycairo-1.21.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.21.0-py3.11_i686/py3_pycairo-1.21.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.21.0-py3.11_x86_64/py3_pycairo-1.21.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e878b14570f630b74a05320daa9778948be4ab7824b9bcd7c0ecb4ba109b4c4d',
     armv7l: 'e878b14570f630b74a05320daa9778948be4ab7824b9bcd7c0ecb4ba109b4c4d',
       i686: '9b49b093ad7304d8c5c2c1e2a853b44ca5e563171f2b3c145ebd41594ff4d070',
     x86_64: 'c6d91f8f299bcd7097f0c401fd0557102769f157667221b894b57a71425da815'
  })

  depends_on 'cairo'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'
  depends_on 'python3' => :build
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
