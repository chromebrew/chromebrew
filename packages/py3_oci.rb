require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.158.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5dd906e044a4b28c2146ef1cd701de323f893c9f674e378052c30b778e7c4688',
     armv7l: '5dd906e044a4b28c2146ef1cd701de323f893c9f674e378052c30b778e7c4688',
       i686: 'ead0095b8d2d150c06b38b41705f2858c227defd6a8d5a418b761a364dec4559',
     x86_64: '132cbb343d6f4bc0292f7b5ff48bd757232f8bc4a38b64de3ff4d7b48c0095f0'
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
