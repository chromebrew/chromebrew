require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.154.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '64c3114dfe6908055ae90a92c613633b8b666d8019521fb92a10d1cf6d4c86ff',
     armv7l: '64c3114dfe6908055ae90a92c613633b8b666d8019521fb92a10d1cf6d4c86ff',
       i686: 'b286b53b7cee69a3f6eb303f1f2245d91fca5b44acdf467918030760d28f352d',
     x86_64: 'bd7e0d7a0b26bcafab64856515ffd4941293d2a081dd8011decf057d4fe0965d'
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
