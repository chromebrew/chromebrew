require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.189.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3fc0a27712ff051d21e9aff49d25a3ddc92b80a74cb9e0a433b49e6c9b3c4bab',
     armv7l: '3fc0a27712ff051d21e9aff49d25a3ddc92b80a74cb9e0a433b49e6c9b3c4bab',
       i686: 'b630c95ed00da1e4f7b4ed2aa85f84568ac1af58389cae0f45ad335099c01752',
     x86_64: '592266cf8986ad6dc7fdc314e463b46500c189a6067cd94cb7684be94c7b2ca0'
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
