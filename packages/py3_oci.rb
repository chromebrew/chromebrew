require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.137.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cc89ccbf70595c37d60754fd93648a410f787a48b9a7d2d5d2c59831f84da762',
     armv7l: 'cc89ccbf70595c37d60754fd93648a410f787a48b9a7d2d5d2c59831f84da762',
       i686: 'deaf971035efccf18e6bb62c40ebb0d7a5e94579e28da0574bf4955fb615d764',
     x86_64: '3e8279e0229c48c3bdb4779f2967aac6fd3390f89890edb25dd7a5f40dff9f60'
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
