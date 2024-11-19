require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.138.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9219ddd363ac2dabe0d32cf979874af4173136445ef89967592841ac35250b58',
     armv7l: '9219ddd363ac2dabe0d32cf979874af4173136445ef89967592841ac35250b58',
       i686: '1e34c230c69254e4a655986c52b8dab33e36b8857287f92fa0bbe0bc61cb3aec',
     x86_64: '2a01eccc3fcc34771e393079faf69d89b98211c95011a3516793ac20ce035fca'
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
