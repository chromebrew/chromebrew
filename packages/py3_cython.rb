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
    aarch64: 'b89833053ff7aadb1fd78230e66f4335d04211d7a1a0985555efcd869547b4c0',
     armv7l: 'b89833053ff7aadb1fd78230e66f4335d04211d7a1a0985555efcd869547b4c0',
       i686: '816d06d69cb84bab63b4a07f5b4f0e59c10347fab773569e9beb8da156026fe0',
     x86_64: 'acf67aaee7d4f9901d21d0b49cb47324e3a16e61161482290cc29a057734fdc3'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
