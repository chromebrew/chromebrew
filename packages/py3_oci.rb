require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.154.3-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ed5a438b8c966511676fc7a0130ffc30e36c51eab8677685d03369de2f2c54f',
     armv7l: '4ed5a438b8c966511676fc7a0130ffc30e36c51eab8677685d03369de2f2c54f',
       i686: '5408c8a96215125f3486a3edc1bf3555212e4151a483f15bd0c35c37d0901640',
     x86_64: '358c59288ef6849162923a105574ba0fc204b10d951387f980ce890e7f86b3c5'
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
