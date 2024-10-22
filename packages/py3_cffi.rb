require 'buildsystems/pip'

class Py3_cffi < Pip
  description 'C Foreign Function Interface for Python calling C code.'
  homepage 'https://cffi.readthedocs.io/'
  version "1.17.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '15288b635c9fbe8a4c3314323af962ed3d04896e182c2b12cdae3e4ce303de99',
     armv7l: '15288b635c9fbe8a4c3314323af962ed3d04896e182c2b12cdae3e4ce303de99',
       i686: '29ace8d2b68c330c4500405c1779b3dfb4572276801babcbd157e08a3eac436b',
     x86_64: '91a092dead86e56e44730f3c53f180a44f38e830acca92b6a50ea9f44b9bb8ea'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # L

  no_source_build
end
