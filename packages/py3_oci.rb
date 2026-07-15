require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.182.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a218a54aa4a4a5de8e95048aedd6d86b237a7761b5415b2bd4063dbfae767d2c',
     armv7l: 'a218a54aa4a4a5de8e95048aedd6d86b237a7761b5415b2bd4063dbfae767d2c',
       i686: '803cb77f1f280a436fc9e086868a3a46db167273510d62ab4963e18ee6d2920f',
     x86_64: '237ae98132a55d592984d633dbcd995ce3b5d5d317bd730c826376c6e165171e'
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
