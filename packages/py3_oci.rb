require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.150.2-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1f306127c5200b02d1451d4f0668353c9438ef2edded4c672c8328be5c2b7ab',
     armv7l: 'e1f306127c5200b02d1451d4f0668353c9438ef2edded4c672c8328be5c2b7ab',
       i686: '8beb480f9389a7f77abf9f5e2588e8e5fefb40ecb2c436b937c90ecbe3385d43',
     x86_64: 'ecc8b4242e48efa11a05b9242e60ffde4d2f35f1089ddb6294dd0b64a266ee38'
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
