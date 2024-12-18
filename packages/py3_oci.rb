require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.141.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f59e36abdc77438627f4efdd37ed9ca9dabe57046f64adfd5d48da487322a1db',
     armv7l: 'f59e36abdc77438627f4efdd37ed9ca9dabe57046f64adfd5d48da487322a1db',
       i686: '8cc9be90914dea8ecdee4d33727a9305a5a805d96de8f473a39a13d247bc126e',
     x86_64: 'f70858675d11813693ab3011fd3fea5bb20ae419af769aa9d4ef661c146e0992'
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
