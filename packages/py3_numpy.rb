require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  @_ver = '1.26.2'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.26.2-py3.12_armv7l/py3_numpy-1.26.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.26.2-py3.12_armv7l/py3_numpy-1.26.2-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.26.2-py3.12_i686/py3_numpy-1.26.2-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_numpy/1.26.2-py3.12_x86_64/py3_numpy-1.26.2-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9de2b4d3aa0824602344338db0a94c6665bc2b935a450cf8b68f92669fc56709',
     armv7l: '9de2b4d3aa0824602344338db0a94c6665bc2b935a450cf8b68f92669fc56709',
       i686: '7df77023c9f1d93252d1f9f3493566bed9b99dda667cb2b05162ba8ecd4aa926',
     x86_64: 'a0011ddbdfd8fd535fd2bfa6147f7265f379992c765b4158da441e9b8d3c5b28'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lapack' => :build
  depends_on 'openblas' # R
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :build
  depends_on 'zlibpkg' # R

  pre_configure_options CREW_ENV_OPTIONS.gsub('mold', 'gold')
end
