require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.153.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '976669f55194959b5ba72ce18ede755d8204d9c94217aa946e2d43b92dff999f',
     armv7l: '976669f55194959b5ba72ce18ede755d8204d9c94217aa946e2d43b92dff999f',
       i686: 'c65d41e88ede628f7f803c444ce0e2d949936de047e37a2a279b12d90c8c7394',
     x86_64: 'e39f0e84804245f4ff5c05ec6eb4f5ed872300248e291659978e4925232659cf'
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
