require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.1.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '66ad2efe2e4aaa4a2663e55bd453fd1985f85d70c177ec25c6e8761f560e03fe',
     armv7l: '66ad2efe2e4aaa4a2663e55bd453fd1985f85d70c177ec25c6e8761f560e03fe',
       i686: '1c8c04fb8ec6eccbf9f709e6401ab5e560cb5a4ff31b5cc31587c6c16f111165',
     x86_64: '7bf7c95e8e0ba781bea74237c8e75eb22378a7804e27348dd518a691ac893e21'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
