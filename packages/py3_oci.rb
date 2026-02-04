require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.167.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c389002fb1f74fd8353746b0fdb30a2b6efde2e692d6d73c33a3fa35d6ba4ae4',
     armv7l: 'c389002fb1f74fd8353746b0fdb30a2b6efde2e692d6d73c33a3fa35d6ba4ae4',
       i686: '06d51ef6bab9a0672ac1bb66a25a358c8f6683866896252e4924470dbd009e37',
     x86_64: '7c0df49d805a9aee3c4f2b09bb88724ccf368d49650bf18fe197a420b0cc2cf2'
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
