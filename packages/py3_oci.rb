require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version '2.134.0-py3.12'
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '721a5605893b5acf7ffe78759b6df446d4bbb0f425460f8b582c8a6a16c1eaed',
     armv7l: '721a5605893b5acf7ffe78759b6df446d4bbb0f425460f8b582c8a6a16c1eaed',
       i686: '2ccecf9406a78e0f75d0fa3b71aa932b1937ef7fb4a83341402312792f8052cc',
     x86_64: '66fbd922295d49198b7ac80a0340b81b31b2ec96580e145c7975b14113f501e2'
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
