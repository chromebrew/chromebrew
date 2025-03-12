require 'buildsystems/pip'

class Py3_oci_cli < Pip
  description 'Command Line Interface for Oracle Cloud Infrastructure'
  homepage 'https://github.com/oracle/oci-cli/'
  version "3.52.1-#{CREW_PY_VER}"
  license 'UPL-1.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'afc2e8285dde0516178d31e3883ca45a44de6b61a8ed77aa9c412d1d856baae3',
     armv7l: 'afc2e8285dde0516178d31e3883ca45a44de6b61a8ed77aa9c412d1d856baae3',
     x86_64: 'dc672a7b1a69d31ace379032c5b58d51368ee9b0dcc864b441c1f4efd5b0a1de'
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
