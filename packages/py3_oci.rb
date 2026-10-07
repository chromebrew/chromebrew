require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.187.2-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dddd19f28e71c576011632d1c6c38387af4997e9e9fed4f5d72f31d740470920',
     armv7l: 'dddd19f28e71c576011632d1c6c38387af4997e9e9fed4f5d72f31d740470920',
       i686: '0da9d50245be6f2366bda5f18250ef44655576e3e48e6348be70b351f7d237f1',
     x86_64: '850db6eb64e9140919fde00eaa6eb52f1bf4ac492e478a47939d1744a8454470'
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
