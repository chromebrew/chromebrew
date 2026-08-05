require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.184.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '783293d3675c50f73600f744eda726908b006e9b5bf27f01ac3e08916ebfee3f',
     armv7l: '783293d3675c50f73600f744eda726908b006e9b5bf27f01ac3e08916ebfee3f',
       i686: 'e12b1aaec432b7ac784578b592ffbd6fe30168560e487263835eea8b6de6d1be',
     x86_64: '6a37dfd5d33673f0e1000601f37aa91209b592474529a043fd5196ee895caeed'
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
