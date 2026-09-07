require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.5.3-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c2962ee206a0d2114860b87ddbabd276cee1e7126540367272c04e9dc842e43',
     armv7l: '3c2962ee206a0d2114860b87ddbabd276cee1e7126540367272c04e9dc842e43',
       i686: 'fb6ef96710d6a2a76910118629c0b336649f5ca4dd4214070a79f6f427ede392',
     x86_64: '77ae546b51b3b3992256d9ba970fbd2d21709985bd3c78806ab4bc92dda20014'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'lapack' => :library
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :logical
  depends_on 'zlib' => :library

  no_source_build
end
