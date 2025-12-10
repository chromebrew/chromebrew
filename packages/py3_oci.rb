require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.164.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f0bb7dabb8865e2ee9d46eaeb4ec3f801d670f516a3081b317f2e45242c3f6b5',
     armv7l: 'f0bb7dabb8865e2ee9d46eaeb4ec3f801d670f516a3081b317f2e45242c3f6b5',
       i686: '8a7a8db0f7ba6140db510e95eb6defa48ea9dc7657657fc099634379a43a851a',
     x86_64: '7630490fc40ff9ed8dc303bb2ddf669890fbf3205daab5fd6846f4c21f452836'
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
