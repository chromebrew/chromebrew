require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.149.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7fff6d61191a3b1b09061686625bffb24fff8ce8705f695c3fb9126f75da001',
     armv7l: 'f7fff6d61191a3b1b09061686625bffb24fff8ce8705f695c3fb9126f75da001',
       i686: '764371f60c00554ef24e9dca57a96030c19ccd8295acfd2093c0e4ab32007176',
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
