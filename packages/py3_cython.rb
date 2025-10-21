require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.1.5-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fdaf2ca6e5d1ca141dfe597ab36e9e2be2bbcc339a8fd48120013fa4e0fb2366',
     armv7l: 'fdaf2ca6e5d1ca141dfe597ab36e9e2be2bbcc339a8fd48120013fa4e0fb2366',
       i686: 'a0bccea1d92e3f7288d5c797b68e98aae2e3fdc5d2458a8d82a730189f6bbdeb',
     x86_64: '7696944a2d956ba0d5eccba25f9f0394a3b919965359122f1767f560d78709e6'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
