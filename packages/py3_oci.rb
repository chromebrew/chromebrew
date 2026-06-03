require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.177.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5e37651574a61525cbeef4c8e76fc0581775d9fa3fb6b049a7d4446611f8ad3f',
     armv7l: '5e37651574a61525cbeef4c8e76fc0581775d9fa3fb6b049a7d4446611f8ad3f',
       i686: '610fc018fb31b3ca97025c6cef9fa6913760752bc8e63e660229db2a12445c05',
     x86_64: '98ae38d4a21e1acc09653ce2f94e5b3bbaf1f10980937bc8f938b7ee9868c288'
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
