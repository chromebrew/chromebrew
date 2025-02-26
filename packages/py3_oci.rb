require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.146.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0e3d429ac153a84c6cd19cbdbe4504c42c2202a846c734d81fa18dbfc549a79',
     armv7l: 'e0e3d429ac153a84c6cd19cbdbe4504c42c2202a846c734d81fa18dbfc549a79',
       i686: '2273d5170577883ad4665981c95ba0684d415812f48e550df42d45a7e07e7932',
     x86_64: '6fb2e3dd0696c572b556d93a6fbc62399ae4865ca4722a07836470ebd945dc3c'
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
