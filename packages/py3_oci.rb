require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.152.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '976669f55194959b5ba72ce18ede755d8204d9c94217aa946e2d43b92dff999f',
     armv7l: '976669f55194959b5ba72ce18ede755d8204d9c94217aa946e2d43b92dff999f',
       i686: '613f40babdab0f8684dfaaf9529f9eb78aa13d201c313a02677247883eacce44',
     x86_64: 'b73ac7d0f027eb4f5bcdf967270db53e128ce18dd48adc838fca97380484669a'
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
