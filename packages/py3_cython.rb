require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.2.4-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b35b05fd372f4c035c7a351aa5d4995afd81999242124305a341ddb59407227b',
     armv7l: 'b35b05fd372f4c035c7a351aa5d4995afd81999242124305a341ddb59407227b',
       i686: 'cfbc409a79d4326ab09d8a2e22a604fbe0f757f4dddb399f1fbafad80d7f7733',
     x86_64: '4a962615d77af44dea7db351bdfaa8c45766ce5fa60fc80a00489fac3690e5ed'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
