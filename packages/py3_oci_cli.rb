require 'buildsystems/pip'

class Py3_oci_cli < Pip
  description 'Command Line Interface for Oracle Cloud Infrastructure'
  homepage 'https://github.com/oracle/oci-cli/'
  version "3.86.0-#{CREW_PY_VER}"
  license 'UPL-1.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09968b38ae9e8d8ce7ac1a913017c7b6eeccde257691a6a7c03e93bde4d9fb68',
     armv7l: '09968b38ae9e8d8ce7ac1a913017c7b6eeccde257691a6a7c03e93bde4d9fb68',
     x86_64: 'd14b141cb8394a047ffdaea8e4373ae851ae249458a1fd990beb854f2298c38d'
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
