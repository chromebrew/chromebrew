require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.161.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec689f3e0a45e292c67209ec75b6d5ee473526d3a844f55096150d66a57a50bc',
     armv7l: 'ec689f3e0a45e292c67209ec75b6d5ee473526d3a844f55096150d66a57a50bc',
       i686: '10bebd442133e9ef6881362a4f27ed6c2879456183e7af9aebb56eb721a4ea8e',
     x86_64: '1e7c282fcc0aabce7abf64f14a62fb32ca6df60f81e5ca71793d0ea02557b806'
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
