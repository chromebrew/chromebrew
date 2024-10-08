require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.135.2-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11f0d9e0f066c818e10a78e96d76c1eb87771d3e12e6278b1cf69b3eeeed3529',
     armv7l: '11f0d9e0f066c818e10a78e96d76c1eb87771d3e12e6278b1cf69b3eeeed3529',
       i686: '964a3b894a86383e96e9781586348830f8cd838943b5b5f5b89bb4579c735742',
     x86_64: 'acff82ed2eca5e4deeb4300fb7f16bacaaf91e78cb00788dd58d90252a8dc4e5'
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
