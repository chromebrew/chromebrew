require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  @_ver = '2023.07.22'
  version "#{@_ver}-py3.12"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2023.07.22-py3.12_armv7l/py3_certifi-2023.07.22-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2023.07.22-py3.12_armv7l/py3_certifi-2023.07.22-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2023.07.22-py3.12_i686/py3_certifi-2023.07.22-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2023.07.22-py3.12_x86_64/py3_certifi-2023.07.22-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '366dd97a23c8115d2cd1a2ee9e3b56d58f8d96e141919dc3b048187751b282d8',
     armv7l: '366dd97a23c8115d2cd1a2ee9e3b56d58f8d96e141919dc3b048187751b282d8',
       i686: 'fde6487f4d23fabfcfbae307793ec6add4863519e20f6f56180155335dc7aa67',
     x86_64: '5f74663e2068ff35b6b89796d19e0b11ea9e1f46f690fc9ecb58e1469712ffbb'
  })

  depends_on 'python3' # L
end
