require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.136.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf03c82ad30a12504db2e897b2532f82ffc919465dccbf562d227f64abc84038',
     armv7l: 'cf03c82ad30a12504db2e897b2532f82ffc919465dccbf562d227f64abc84038',
       i686: 'a1deda46d144f6b4df9e0fa530d2a245eec90a18a6fe6a523ea4320dc05c8ed9',
     x86_64: '259334f0579b128f7b2ed3db787c1774e6037fd52099c7373f82bdfcd58be6d6'
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
