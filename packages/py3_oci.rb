require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.150.3-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e9213e9b8414ca8f7d59635346c69f7d482a1709c00f1480cfc6832caf85bdf5',
     armv7l: 'e9213e9b8414ca8f7d59635346c69f7d482a1709c00f1480cfc6832caf85bdf5',
       i686: '578943b3e92120d48cf49a5f49d7c86f55723a8851591fd562bf39d00643d91e',
     x86_64: 'ae1565ab3545bfcc189882e3b5ce2095936536458b7de00aeafe68926f3b2cbe'
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
