require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.160.3-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c8e2ef596c19d7e508bccda12c80083376c8da5c28a101ed133571b9052d3aea',
     armv7l: 'c8e2ef596c19d7e508bccda12c80083376c8da5c28a101ed133571b9052d3aea',
       i686: '8c42e9addb8c409e7940bcb9ffdd4ca4634da312e15d681e828964af75839e6e',
     x86_64: '14508f052732cc3ea5fb9fa4736c2464e036fa4aa88ac82806fd9b7691ca7221'
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
