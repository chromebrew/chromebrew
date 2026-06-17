require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.179.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '786efd3c095465811f30f3155ead1f34066e25b7c545281b305516237cc7505a',
     armv7l: '786efd3c095465811f30f3155ead1f34066e25b7c545281b305516237cc7505a',
       i686: 'a4d9f5cb1cef5194994f147d922338da57179c25828f8d96a0cbb9abe3a1335e',
     x86_64: 'e328b78b4d852122138d4b2cead831da76c9cb4c98388176df14cd40951cba51'
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
