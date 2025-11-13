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
    aarch64: '0f7d72f84ef7ee840a7fecdf5b274b81f89b79c9593bb9a7a31c2fd2b7fa71c8',
     armv7l: '0f7d72f84ef7ee840a7fecdf5b274b81f89b79c9593bb9a7a31c2fd2b7fa71c8',
       i686: '4a83487ea140f0d63342a610bee5e1a46b01e410350610310e8c8f308cb18754',
     x86_64: '69657e544d39d94bd18473efbb067289af8d71faed8b584b7ea07b3fec41dbc5'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
