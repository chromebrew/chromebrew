require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.161.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b04ea166d5bb6530bf488f4550ad5e4b49558bde4f767450af43645dda752b3c',
     armv7l: 'b04ea166d5bb6530bf488f4550ad5e4b49558bde4f767450af43645dda752b3c',
       i686: '74c78a71dcc6cd0ad0b7fe65cd01466fa70786b6904ad34bec8d7956d32c8481',
     x86_64: 'c827d89ac0bd85de11fa9014a4b54154e00c52a63ae2ab5a7019d09e8ceca54d'
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
