require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.175.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9bba9873e855119482966a9773cc6f9a156758e9053504daef075229ce5458de',
     armv7l: '9bba9873e855119482966a9773cc6f9a156758e9053504daef075229ce5458de',
       i686: 'f5357a606a5173143915bc42fe4d2406bb548ea93bf4a3e26ff96b93517d2f7b',
     x86_64: '1dbc18c37a864d7b04fc769e8cea1375dedba01d994335f087ccd2f927be5eea'
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
