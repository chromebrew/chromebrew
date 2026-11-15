require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.191.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5455c50e5de028f78361bf96688733a1289b96887b1fe957402dcee5184e8843',
     armv7l: '5455c50e5de028f78361bf96688733a1289b96887b1fe957402dcee5184e8843',
       i686: 'd68a7cabb1ee1bac019e308e19f0890812894f68149aaa490a6afd4a629947a6',
     x86_64: '84ea23b44f0cd7f7a8916a017eb5e53fa954b09bcf6310d3e53f7f2fa8b2ca05'
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
