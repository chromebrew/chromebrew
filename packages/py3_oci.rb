require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.165.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c9093ef1e5f9d97afff082242799dcc4084feb7decf0bd58791f8d65600de3a',
     armv7l: '7c9093ef1e5f9d97afff082242799dcc4084feb7decf0bd58791f8d65600de3a',
       i686: '8c9c5c0bca4924174c7e139f3623a7af527ea5fafdcea8a31b106dfb74183038',
     x86_64: '1640073d78644d15cf7588b3fbd800c97b8156ce2fc6e609492127cabaac9c7b'
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
