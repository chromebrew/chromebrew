require 'buildsystems/pip'

class Py3_oci_cli < Pip
  description 'Command Line Interface for Oracle Cloud Infrastructure'
  homepage 'https://github.com/oracle/oci-cli/'
  version "3.90.2-#{CREW_PY_VER}"
  license 'UPL-1.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1995983c37ba8ca489346091695e897339771702e0a6e0cb9aa3cc67550503e',
     armv7l: 'c1995983c37ba8ca489346091695e897339771702e0a6e0cb9aa3cc67550503e',
     x86_64: 'decf2d024e593318fa10e683ae1baffa4a9132c42a7ce5cbffb8d120379f15de'
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
