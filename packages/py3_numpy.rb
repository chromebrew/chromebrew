require 'package'

class Py3_numpy < Package
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  @_ver = '1.21.4'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/numpy/numpy.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.21.4_armv7l/py3_numpy-1.21.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.21.4_armv7l/py3_numpy-1.21.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.21.4_i686/py3_numpy-1.21.4-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.21.4_x86_64/py3_numpy-1.21.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'eb62980656c6cafe8ee1bd97ae0d6d6dff5402f9ff7a1f5f3687074661897c4d',
     armv7l: 'eb62980656c6cafe8ee1bd97ae0d6d6dff5402f9ff7a1f5f3687074661897c4d',
       i686: '17fe1d24ba66b5316c12a43ee64c1d59670cde1ab6179eb71dce1b8c6ea5dee4',
     x86_64: '59b54964979b170cb4076b98a0ac1e67cb1292b2d472ed9c39c66199d835f54a'
  })

  depends_on 'lapack'
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
