require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.2.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1c5b943b4144fc614e7d997b779ed56abe61213701167b56b9f5858ae41e5c38',
     armv7l: '1c5b943b4144fc614e7d997b779ed56abe61213701167b56b9f5858ae41e5c38',
       i686: 'cf5471a66d40f63d893701b3a38b59e8a816a973c448d16e7aacfb3ab7f5d23c',
     x86_64: '4bea80f0d01458c9e04dbf95964f5e41310016f78b5b9bbc7c3401ea0240bef7'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
