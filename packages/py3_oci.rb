require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.160.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '35d7f22bd35381f604cf0bd41880e90499bcc68b8298821cfde46722526b3c43',
     armv7l: '35d7f22bd35381f604cf0bd41880e90499bcc68b8298821cfde46722526b3c43',
       i686: 'd3210b021a088074f3b189241d79b4a56872e31a2b70475ee7eecf5d9a002b75',
     x86_64: 'b40631232c7b2015c66c594c356031e526c3f8341eead64a9a1f2e2330957469'
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
