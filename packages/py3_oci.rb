require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.144.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af2f8514ee73a7c34a0dd33103a57b18a2aab2bdb9a66db9ed951c04657cc3b3',
     armv7l: 'af2f8514ee73a7c34a0dd33103a57b18a2aab2bdb9a66db9ed951c04657cc3b3',
       i686: 'd9ba76f7c96762f3daca384baf5045672446dbcc0e8ec0524c6fdfddd9afa63b',
     x86_64: 'd850607541207f612407c595714cac790704881520e4da2362b837d49b2b5060'
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
