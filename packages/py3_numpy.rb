require 'package'

class Py3_numpy < Package
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  @_ver = '1.23.5'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/numpy/numpy.git'
  git_hashtag "v#{@_ver}"
  git_fetchtags

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.23.5-py3.11_armv7l/py3_numpy-1.23.5-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.23.5-py3.11_armv7l/py3_numpy-1.23.5-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.23.5-py3.11_i686/py3_numpy-1.23.5-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.23.5-py3.11_x86_64/py3_numpy-1.23.5-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cbc553a992632a5dffafce74961a7aaa29418507ba734043d2a85a9fe93fa461',
     armv7l: 'cbc553a992632a5dffafce74961a7aaa29418507ba734043d2a85a9fe93fa461',
       i686: '74b19513ee9f8bd43b2b488d214938088d738abbfa71435bf23489f0b1d94748',
     x86_64: '728b3c482536bc36ba8962301ae7ab4e48056d63447acf351eacaa17ecf4d78a'
  })

  depends_on 'lapack'
  depends_on 'py3_cython' => :build
  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
