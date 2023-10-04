require 'buildsystems/pip'

class Py3_brotlicffi < Pip
  description 'Python bindings to the Brotli compression library'
  homepage 'https://github.com/python-hyper/brotlicffi/'
  @_ver = '1.1.0.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_brotlicffi/1.1.0.0-py3.12_armv7l/py3_brotlicffi-1.1.0.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_brotlicffi/1.1.0.0-py3.12_armv7l/py3_brotlicffi-1.1.0.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_brotlicffi/1.1.0.0-py3.12_i686/py3_brotlicffi-1.1.0.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_brotlicffi/1.1.0.0-py3.12_x86_64/py3_brotlicffi-1.1.0.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '290992d3861bf461ff5bd5020e1d76df5bb32760bb4c79446300125efcd61fe1',
     armv7l: '290992d3861bf461ff5bd5020e1d76df5bb32760bb4c79446300125efcd61fe1',
       i686: '08cadd4082e60afcc5da4ce6c3baaba037d408eb21827a6c75d3b78464e3cd43',
     x86_64: '9180e02028d48325c210c2fba6e63a4c29e10c0e2b8d663d2bf80f2ba08bfef4'
  })

  depends_on 'brotli'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'python3' # L
end
