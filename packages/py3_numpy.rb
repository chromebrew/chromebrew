require 'package'

class Py3_numpy < Package
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  @_ver = '1.20.2'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/numpy/numpy.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.20.2_i686/py3_numpy-1.20.2-chromeos-i686.tar.xz',
 aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.20.2_armv7l/py3_numpy-1.20.2-chromeos-armv7l.tpxz',
  armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.20.2_armv7l/py3_numpy-1.20.2-chromeos-armv7l.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.20.2_x86_64/py3_numpy-1.20.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: '15358c391e68667f3ceb607a16720093806a7840c6da526d7078a52b195b63e3',
 aarch64: 'de21a40aeb98be94b3546d2b49452679fc281170ae6377f35f384823beab3469',
  armv7l: 'de21a40aeb98be94b3546d2b49452679fc281170ae6377f35f384823beab3469',
  x86_64: 'abed005b2ae64c691a275d21101dd1d87a8dba3351630883d26264b2e47cd0ab'
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
