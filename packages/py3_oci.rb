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
    aarch64: '56b824d5b5000447d6a45c78111f5fe6e9ab3b50d6f8f0148af7f87e11c962b0',
     armv7l: '56b824d5b5000447d6a45c78111f5fe6e9ab3b50d6f8f0148af7f87e11c962b0',
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
