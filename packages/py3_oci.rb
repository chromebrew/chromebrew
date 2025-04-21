require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.150.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80d386bd726675951430458c8dcf40cccc3f1dfb2d5784819a820755ef4c4843',
     armv7l: '80d386bd726675951430458c8dcf40cccc3f1dfb2d5784819a820755ef4c4843',
       i686: '8beb480f9389a7f77abf9f5e2588e8e5fefb40ecb2c436b937c90ecbe3385d43',
     x86_64: 'e66e4ec5b7d7ed0afbfd961bfb15195dd7a2d27a2eaafa80815c5becb1c099a2'
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
