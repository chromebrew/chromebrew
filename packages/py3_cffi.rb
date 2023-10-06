require 'buildsystems/pip'

class Py3_cffi < Pip
  description 'C Foreign Function Interface for Python calling C code.'
  homepage 'https://cffi.readthedocs.io/'
  @_ver = '1.15.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # L

  no_compile_needed
end
