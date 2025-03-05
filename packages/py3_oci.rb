require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.147.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2dceda29706584cc7aed4a6a7eb297597813b03088f7de19a4bf3c63aa542483',
     armv7l: '2dceda29706584cc7aed4a6a7eb297597813b03088f7de19a4bf3c63aa542483',
       i686: 'ca0f58e8dad798d8ad519d5cbd6f5642dd7de68fd17c503927a834c2e4042142',
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
