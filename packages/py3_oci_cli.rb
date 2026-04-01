require 'buildsystems/pip'

class Py3_oci_cli < Pip
  description 'Command Line Interface for Oracle Cloud Infrastructure'
  homepage 'https://github.com/oracle/oci-cli/'
  version "3.77.0-#{CREW_PY_VER}"
  license 'UPL-1.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aac0d3bd3e7c5ac165c832ca4a8a92b3242f6cbf51a5a531a38ce81f7a69e243',
     armv7l: 'aac0d3bd3e7c5ac165c832ca4a8a92b3242f6cbf51a5a531a38ce81f7a69e243',
     x86_64: 'dbab80877c5b8defa9974451e4c8eff59b273009c9cf8ab45f57362cc5e85191'
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
