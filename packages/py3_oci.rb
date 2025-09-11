require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.160.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '96afc288f66cb158179f648cb2014b4ff4782fbe14068b064040e6d03d6e7383',
     armv7l: '96afc288f66cb158179f648cb2014b4ff4782fbe14068b064040e6d03d6e7383',
       i686: '6fa89d71f781e5a6a32ed74fc1c889f21bf8fd76119eba2e8b5de7b07d8d95a8',
     x86_64: '022ef2b2945fab176618d5f57b4272e76e1224dfe560243a1a1adf35f158c9dd'
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
