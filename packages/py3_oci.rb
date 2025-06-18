require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.154.2-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '64c3114dfe6908055ae90a92c613633b8b666d8019521fb92a10d1cf6d4c86ff',
     armv7l: '64c3114dfe6908055ae90a92c613633b8b666d8019521fb92a10d1cf6d4c86ff',
       i686: 'b57de3ef1e56e743544fec8ac20f505178c57fd2677982c48118555ca2927990',
     x86_64: 'd4a9a233d04468189562f476efb9b634700b188562efea86bf964c57b71eba87'
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
