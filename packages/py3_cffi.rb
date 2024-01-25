require 'buildsystems/pip'

class Py3_cffi < Pip
  description 'C Foreign Function Interface for Python calling C code.'
  homepage 'https://cffi.readthedocs.io/'
  @_ver = '1.16.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be7b4b4dd95c644bffc6fc6b795996d48b050242f75e0bd6fe8d7b821e6eca71',
     armv7l: 'be7b4b4dd95c644bffc6fc6b795996d48b050242f75e0bd6fe8d7b821e6eca71',
       i686: 'a63cd7198f632e81164702064e4dccdaa0ad2512127f54ecdf5407402c80d40d',
     x86_64: '735cad77a2e874ceeaabed1318300305dc5622f29907afb5a46041d963c981d5'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # L

  no_compile_needed
end
