require 'buildsystems/pip'

class Py3_oci_cli < Pip
  description 'Command Line Interface for Oracle Cloud Infrastructure'
  homepage 'https://github.com/oracle/oci-cli/'
  version "3.56.0-#{CREW_PY_VER}"
  license 'UPL-1.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '72b7a38222e8768cc012e0425324cd0edde007c63f1cda0c8e8696142613c6d4',
     armv7l: '72b7a38222e8768cc012e0425324cd0edde007c63f1cda0c8e8696142613c6d4',
     x86_64: 'e8b27f3cbcffb9fa1caea941877e8273836aaeec3d4c258d61f83a9384f4541e'
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
