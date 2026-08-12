require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.184.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0603d0e105e5e0c3fb2a77e13b73048c2e550327702ddc9c686601d180ebaa43',
     armv7l: '0603d0e105e5e0c3fb2a77e13b73048c2e550327702ddc9c686601d180ebaa43',
       i686: '71112f3998b8fe2d7fc7a84654d1d8cf46e0cb11f427d4a1a4cba8913f5f1cf9',
     x86_64: '3e1bb22590b09f18a4c52a91ff0f371017eeeb4900c8bd603409bbfc2a96c0b2'
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
