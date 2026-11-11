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
    aarch64: '2dadfb7336372f91f5e89284d404f639923a7278f714074e1f469e7d4ee197a9',
     armv7l: '2dadfb7336372f91f5e89284d404f639923a7278f714074e1f469e7d4ee197a9',
       i686: '1a6422a9410baeccb020a711fc48abb6f8c8a63dee13aa2cfc7cb7fff6548ccb',
     x86_64: '22d9a199e6ac10429ddcdf496a1293d97703091bd01efb6a0e84326814fbcbff'
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
