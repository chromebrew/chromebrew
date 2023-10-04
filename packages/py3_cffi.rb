require 'buildsystems/pip'

class Py3_cffi < Pip
  description 'C Foreign Function Interface for Python calling C code.'
  homepage 'https://cffi.readthedocs.io/'
  @_ver = '1.15.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/2b/a8/050ab4f0c3d4c1b8aaa805f70e26e84d0e27004907c5b8ecc1d31815f92a/cffi-1.15.1.tar.gz'
  source_sha256 'd400bfb9a37b1351253cb402671cea7e89bdecc294e8016a707f6d1d8ac934f9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.1-py3.12_armv7l/py3_cffi-1.15.1-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.1-py3.12_armv7l/py3_cffi-1.15.1-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.1-py3.12_i686/py3_cffi-1.15.1-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.15.1-py3.12_x86_64/py3_cffi-1.15.1-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3a215dbe5c68135a825bc37cfc1bd9c1e84697b5ade3707e267de96f0ea33ee6',
     armv7l: '3a215dbe5c68135a825bc37cfc1bd9c1e84697b5ade3707e267de96f0ea33ee6',
       i686: '0f1a889b6a2a78c8420412cc949d527e4b7465e14b8b688ad6f9b8ac9a3d18ef',
     x86_64: '6d1abeeb6ac6464c9d2ff8f13692997bb9b1bff4a8492be1088033d9bc9d8b1f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # L
end
