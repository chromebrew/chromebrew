require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.2.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f14020b9434e3b7ef06302de95eb71523f5c8ab7b80fd9c11cd2b47ab3d1672',
     armv7l: '4f14020b9434e3b7ef06302de95eb71523f5c8ab7b80fd9c11cd2b47ab3d1672',
       i686: '6ecbdfdc0bcdaa055622a8b25345e578104a20661b064b8f46fb74d02640266d',
     x86_64: 'ef88e72106582fc73dc13914cda21b6bd77f230fae7850a981db3f73e057a9cf'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
