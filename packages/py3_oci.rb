require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.144.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c4c411f2600a6cc2f11b2dc276f780892ec6b2c85e95a32a7a5d7691c630907f',
     armv7l: 'c4c411f2600a6cc2f11b2dc276f780892ec6b2c85e95a32a7a5d7691c630907f',
       i686: 'b74c45426a117ea8b070662600cee1bd26053c2cc0285ab79c26db6d71a6adab',
     x86_64: 'bbcee26b42a85f368dca3de0bbeff82b94012f1d94ea39410b943bd7e40fc119'
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
