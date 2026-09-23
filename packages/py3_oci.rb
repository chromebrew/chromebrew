require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.187.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da9b9badac1cc2517d9dbe3ca386c54eb74e455b0f6e4d030716afdb406838d3',
     armv7l: 'da9b9badac1cc2517d9dbe3ca386c54eb74e455b0f6e4d030716afdb406838d3',
       i686: 'df1aef41da7df3c1daba6310da9bbafba272cc0a977bed1c2c3e885b3044df87',
     x86_64: 'cb7a12fafb792a323305a666e94bd70bc556680f18426a5a08dae410e62159a9'
  })

  depends_on 'py3_certifi'
  depends_on 'py3_configparser'
  depends_on 'py3_cryptography'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_python_dateutil'
  depends_on 'py3_pytz'
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
