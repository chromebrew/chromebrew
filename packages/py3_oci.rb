require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.173.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bacdc9d5e51cbd5cb217df4fd881c4f323e79be74f1d4c220089b25794e75b21',
     armv7l: 'bacdc9d5e51cbd5cb217df4fd881c4f323e79be74f1d4c220089b25794e75b21',
       i686: 'e35b11aac9dd8c349c15f0eb21c99898066a98b57c90d8547dae0b0d2b6e2124',
     x86_64: '2b609b427a0ed794bea3b6160658ce60039c151d995d851b6f092b8e3c9422ba'
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
