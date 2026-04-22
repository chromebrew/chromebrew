require 'buildsystems/pip'

class Py3_oci_cli < Pip
  description 'Command Line Interface for Oracle Cloud Infrastructure'
  homepage 'https://github.com/oracle/oci-cli/'
  version "3.80.0-#{CREW_PY_VER}"
  license 'UPL-1.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '38275f5f973a949e5feb9b4463596e8a899a14759b79462fd9611ab7b8d2d075',
     armv7l: '38275f5f973a949e5feb9b4463596e8a899a14759b79462fd9611ab7b8d2d075',
     x86_64: '1a0666c099e4db1c2b52d48e6ee9b7f3cd7d3ec2ed875dcc61e7ec0e4852ebba'
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
