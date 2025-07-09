require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.155.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c8eb85b17b8ea0926e9e053c695bd96ee7a3eb9e966375b70db6450c7aadf504',
     armv7l: 'c8eb85b17b8ea0926e9e053c695bd96ee7a3eb9e966375b70db6450c7aadf504',
       i686: '16e1ed5fa8ec21bf7cb6b9a1831023a704747a336ed01b3d64648bfaf5e9b09a',
     x86_64: 'cd794eed853757863edf25287aacbf7a21eeca69104fcf9facc1ef0ea9e16a7a'
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
