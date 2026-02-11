require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.167.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd0cc1b34f1fbfd08d52ec6224cccb54896d6df80ab61a9e692e4cfae5b8a3760',
     armv7l: 'd0cc1b34f1fbfd08d52ec6224cccb54896d6df80ab61a9e692e4cfae5b8a3760',
       i686: '51aa5d34985ec1ad531aee369159d834c16f794369379fd70075365f78c9ac75',
     x86_64: '3622e2e9da1c4f155b3bc0b5ed3976c45936e926bec0b72d9b7bca8442c441e1'
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
