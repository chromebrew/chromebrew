require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.185.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd25b66c4e0fe7c8af69822e6e8bdbe9c97f3b6c168f48fe18a3c4f217000cd4',
     armv7l: 'bd25b66c4e0fe7c8af69822e6e8bdbe9c97f3b6c168f48fe18a3c4f217000cd4',
       i686: 'a75af31d4ff46e7450d9b53f6dc4c63de74903641383947b4da6c905e73de5d5',
     x86_64: 'd476fc056c34a58f43efb812f7ff0699bb2c3576a106e9023332f03a72edaaea'
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
