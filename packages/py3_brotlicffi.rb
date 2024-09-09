require 'buildsystems/pip'

class Py3_brotlicffi < Pip
  description 'Python bindings to the Brotli compression library'
  homepage 'https://github.com/python-hyper/brotlicffi/'
  version '1.1.0.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'brotli'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'python3' # L

  no_source_build
end
