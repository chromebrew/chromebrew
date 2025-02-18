require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.145.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0e3d429ac153a84c6cd19cbdbe4504c42c2202a846c734d81fa18dbfc549a79',
     armv7l: 'e0e3d429ac153a84c6cd19cbdbe4504c42c2202a846c734d81fa18dbfc549a79',
       i686: '6f1a0952283e99595b6410e1b8c59336c2e547fb650bc2cca104fb55d702ec68',
     x86_64: '189d83242eafb25b6bf39a536989a91e335cc8d469e2a98e7333472a22a2b9d8'
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
