require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.1.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '72dc28ec01a5045346bcb683dc8493175ccb1856b80eec8366634c30511b0045',
     armv7l: '72dc28ec01a5045346bcb683dc8493175ccb1856b80eec8366634c30511b0045',
       i686: '5242fae9ceecc503f79b322703c9dc4c893091d0b56f895d8c7fd43bfc3bd24b',
     x86_64: '1609c74d61ef5324be8cb967f387e7fabd257133b05f27582878a625bd2f431a'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
