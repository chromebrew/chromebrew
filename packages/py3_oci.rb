require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.182.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71890114cd21093faa9f9838c94d18c9bb72f8960aedd3f33862a79fd8f23be6',
     armv7l: '71890114cd21093faa9f9838c94d18c9bb72f8960aedd3f33862a79fd8f23be6',
       i686: 'bb949a3c8d2f7a0f2ec27d920e1c2fa2eab9d5e4ccd9cfd83b2585e10c87be1b',
     x86_64: '4e195c29a89ba58257a6892bbc13410e78c21142cf722f5e43bb442213d71def'
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
