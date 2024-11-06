require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.137.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '976d5d7b9675e18729ce4ab8a411ca9de65f877a7397ec8733cd11b410f77d3c',
     armv7l: '976d5d7b9675e18729ce4ab8a411ca9de65f877a7397ec8733cd11b410f77d3c',
       i686: 'ebf6b04c9afecd7168a4bf3713ad6e670c27304b5d965b43c3bf8c486c63e33e',
     x86_64: '0edd9af9594d2ac55b27c1fdad160aef4f01f0257636f3b3fc3bcc031ae46954'
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
