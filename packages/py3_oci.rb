require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.184.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c61b4132acf8a81a003a1f5d024eb196489cca4147ef1afc9c888036a97169b',
     armv7l: '0c61b4132acf8a81a003a1f5d024eb196489cca4147ef1afc9c888036a97169b',
       i686: '8f712d83ef505900850bdceca510b0c006b0bfbb9eefb27ca31553de9e1aef46',
     x86_64: 'e40b8cad751c78c6c495bfa252fcef3820e838b1f44454a7e488189f052a8d35'
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
