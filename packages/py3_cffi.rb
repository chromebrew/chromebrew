require 'buildsystems/pip'

class Py3_cffi < Pip
  description 'C Foreign Function Interface for Python calling C code.'
  homepage 'https://cffi.readthedocs.io/'
  version '1.17.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'


  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # L

  no_compile_needed
end
