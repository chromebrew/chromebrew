require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.165.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '871ca3eb2c018de99bb45b30bea680bbfcc90e3bda85f22e57fde5e8dcd04602',
     armv7l: '871ca3eb2c018de99bb45b30bea680bbfcc90e3bda85f22e57fde5e8dcd04602',
       i686: 'f41471bc947dcf66e97ae489bbb3e3178bcfd9d49041f6490bd5ccc2411cf243',
     x86_64: '0c0b76f2119d6a718cbc5815c7b2374d62113f3c24943f92f77fdfc4a5f4b8a0'
  })

  depends_on 'py3_python_dateutil'
  depends_on 'py3_configparser'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_certifi'
  depends_on 'py3_pytz'
  depends_on 'py3_cryptography'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
