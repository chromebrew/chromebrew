require 'buildsystems/pip'

class Py3_oci_cli < Pip
  description 'Command Line Interface for Oracle Cloud Infrastructure'
  homepage 'https://github.com/oracle/oci-cli/'
  version "3.49.0-#{CREW_PY_VER}"
  license 'UPL-1.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '009cb382ce6b41478a137ebab2bacc605cd7b87db1fc69110c8c904e4d2bbd1c',
     armv7l: '009cb382ce6b41478a137ebab2bacc605cd7b87db1fc69110c8c904e4d2bbd1c',
     x86_64: '0fa5c2a699fa9c21c7e099fde30978a3a9f8586c279a592f37dba73f71a9750c'
  })

  depends_on 'py3_arrow'
  depends_on 'py3_six'
  depends_on 'py3_terminaltables'
  depends_on 'py3_certifi'
  depends_on 'py3_python_dateutil'
  depends_on 'py3_click'
  depends_on 'py3_jmespath'
  depends_on 'py3_retrying'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_pyyaml'
  depends_on 'py3_cryptography'
  depends_on 'py3_configparser'
  depends_on 'py3_pytz'
  depends_on 'py3_oci'
  depends_on 'python3' => :build

  no_source_build
end
