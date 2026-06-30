require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.2.8-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe7b2a38c3252fcb84aa6f5e4fb7ca779e8172848ef7325f623c52cbda334d2d',
     armv7l: 'fe7b2a38c3252fcb84aa6f5e4fb7ca779e8172848ef7325f623c52cbda334d2d',
       i686: '02a7dab0a7d981e2873f01ed5e8bdace9eff6289ade46adef91c274d395545bd',
     x86_64: 'e153312453319b65edb94d788d9c6625ea7e16595c3d462486dd122f64e75267'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
