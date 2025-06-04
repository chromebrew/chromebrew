require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.154.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff913c928d33c75f073189bd05797872dbe5dbfbfc844e9b618b86a4fb5afc17',
     armv7l: 'ff913c928d33c75f073189bd05797872dbe5dbfbfc844e9b618b86a4fb5afc17',
       i686: '4ecb31f22ff284f0c4f0a65c8ed6b4906481c3cd48ec75b4b59b745a9d5f9e7c',
     x86_64: '0a44ac8dbe65485cabbe3f6c974a7e763267c0b063138685c8553347e254c8f5'
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
