require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.3.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2ff58b814ba7a02db6129a83d54b5a60cee218ff7515b41c634e0148818fa89',
     armv7l: 'a2ff58b814ba7a02db6129a83d54b5a60cee218ff7515b41c634e0148818fa89',
       i686: 'fb88b8c4f134d45e5389cf1d274ad94832b4686932b13ac893c30ae45c76e5ad',
     x86_64: '782f9265538b063de5829deaee4743e045713de2f4f5ac42914c4bfe32abbd49'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
