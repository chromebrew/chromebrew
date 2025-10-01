require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.160.3-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c8df528022b89555b499c647dec07a360d1f04759f191620554d15c965951e48',
     armv7l: 'c8df528022b89555b499c647dec07a360d1f04759f191620554d15c965951e48',
       i686: 'abd70f2a6507d7cc046b898acc44e77b0fd11dd7b162e09ca0d5d18aaa8b594b',
     x86_64: 'ce137210432caf197553e0a6e8bbc75ab259c7bff8d13925753b05453c982b12'
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
