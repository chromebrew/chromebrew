require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.155.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ed5a438b8c966511676fc7a0130ffc30e36c51eab8677685d03369de2f2c54f',
     armv7l: '4ed5a438b8c966511676fc7a0130ffc30e36c51eab8677685d03369de2f2c54f',
       i686: '43d7a23c780de90eda307e8d1ae37ddfcf6e6bca6fba6551a1619455e5993bdb',
     x86_64: 'f83de513d074c1932b6101efbf49608d174935ce4704bdfb318323eccf1532ef'
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
