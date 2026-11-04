require 'buildsystems/pip'

class Py3_oci_cli < Pip
  description 'Command Line Interface for Oracle Cloud Infrastructure'
  homepage 'https://github.com/oracle/oci-cli/'
  version "3.96.0-#{CREW_PY_VER}"
  license 'UPL-1.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '67bc10bef2b0deb2b08d4076ad1bc3dee3d4d936fa5c674b0b603cdb458a28da',
     armv7l: '67bc10bef2b0deb2b08d4076ad1bc3dee3d4d936fa5c674b0b603cdb458a28da',
     x86_64: 'c3d0c0ec8c55d11ba02cf2dc25d5af4adc26854110f88438185db74f05589fa6'
  })

  depends_on 'py3_arrow'
  depends_on 'py3_certifi'
  depends_on 'py3_click'
  depends_on 'py3_configparser'
  depends_on 'py3_cryptography'
  depends_on 'py3_jmespath'
  depends_on 'py3_oci'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_python_dateutil'
  depends_on 'py3_pytz'
  depends_on 'py3_pyyaml'
  depends_on 'py3_retrying'
  depends_on 'py3_six'
  depends_on 'py3_terminaltables'
  depends_on 'python3' => :logical

  no_source_build
end
