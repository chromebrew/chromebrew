require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.144.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ca75e61446f60f6602b70b6b9dad3b5786452502a1c5f1fbcf47a55b82f81a1',
     armv7l: '1ca75e61446f60f6602b70b6b9dad3b5786452502a1c5f1fbcf47a55b82f81a1',
       i686: '166bc265316183ec00f984dd41cde9e5c709eb0a41b642408b7ffd2d14b20dc0',
     x86_64: '4b0bd33512136d2f4c63b00b5bb25535818f643a9acbde748fcfeec92e5daaae'
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
