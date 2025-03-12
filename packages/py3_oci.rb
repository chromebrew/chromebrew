require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.148.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7fff6d61191a3b1b09061686625bffb24fff8ce8705f695c3fb9126f75da001',
     armv7l: 'f7fff6d61191a3b1b09061686625bffb24fff8ce8705f695c3fb9126f75da001',
       i686: '7a7c1b0d5b709237c8c3282e5e9f5d5a25b7757cce47859b3f0f6f4fb3407c15',
     x86_64: 'cde9bf875bef3254831d06aeb96ea767174d9c6c21350304d2d062a47a4dd004'
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
