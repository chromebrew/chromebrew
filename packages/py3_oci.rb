require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.182.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '605e4a00a99093f0b31d58006ea9ad45499bfc0a2ffbcbc3dd240f83b4525e56',
     armv7l: '605e4a00a99093f0b31d58006ea9ad45499bfc0a2ffbcbc3dd240f83b4525e56',
       i686: 'e7763c83e640d19f21b49f425345b476bf813d66ff80fb970545d370e2568af7',
     x86_64: '1f5e7b788b6e4892395924254bc6e4db061f2c946a1a1f5e5cef5e33cd0f2aa4'
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
