require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.185.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bcd7dfd08d1cd5d9f108e753a8e6e1af482e6dc443b8d22f064e8071224fb23e',
     armv7l: 'bcd7dfd08d1cd5d9f108e753a8e6e1af482e6dc443b8d22f064e8071224fb23e',
       i686: 'b675acae013fdfa6307ab68070945424f9e79e2779ecd4710d42b10afeb067f3',
     x86_64: 'b03f61c10c1ab1deb7f3482202b4059ff51f4eeb807f67fc96b9af74c5600ef6'
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
