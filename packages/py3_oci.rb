require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.156.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '31a1e5918818b178c32ce5986884653c9d456201308b49bda4a8c5c15cab8baf',
     armv7l: '31a1e5918818b178c32ce5986884653c9d456201308b49bda4a8c5c15cab8baf',
       i686: '09cf0825437fd718d3f919002c5a2e2520ffae9d26a56973edb264359da3097b',
     x86_64: '021b21cd425569c5cfacb3e8fb1c1ffcc7ff346799b7579340321ca05de72af8'
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
