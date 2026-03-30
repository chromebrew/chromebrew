require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.4.4-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d57cdf63014dfda8e541f53f6c8315450deafe73e77873d07f5cdcd535e24cd',
     armv7l: '2d57cdf63014dfda8e541f53f6c8315450deafe73e77873d07f5cdcd535e24cd',
       i686: 'f1275fb1fbaba39e043e3dcf5a7320cdafc715217d5c9752041d2ccc078b8844',
     x86_64: '1a3d95f60dde4668fd96415b339659dc43d4db4425d271b01584f5e67b44fe2e'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'lapack' => :library
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :logical
  depends_on 'zlib' => :library

  no_source_build
end
