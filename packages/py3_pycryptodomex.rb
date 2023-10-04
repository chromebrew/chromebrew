require 'buildsystems/pip'

class Py3_pycryptodomex < Pip
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  @_ver = '3.19.0'
  version "#{@_ver}-py3.12"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.19.0-py3.12_armv7l/py3_pycryptodomex-3.19.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.19.0-py3.12_armv7l/py3_pycryptodomex-3.19.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.19.0-py3.12_i686/py3_pycryptodomex-3.19.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.19.0-py3.12_x86_64/py3_pycryptodomex-3.19.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '94f3b0d7eda1b423f94574e14b68ee6d67dead365beef771150c3dd0e6591cd2',
     armv7l: '94f3b0d7eda1b423f94574e14b68ee6d67dead365beef771150c3dd0e6591cd2',
       i686: 'a0d61f0d91fa74f4ba5fa175afb995b5c21edff079330dd5fbb8b17df0ef5b3e',
     x86_64: '3f5ddb4fde7f940ec161b26fbb02825b3688cce045183de22b786ccb4c9eb2e1'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # L
end
