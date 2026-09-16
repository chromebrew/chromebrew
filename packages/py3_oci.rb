require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.186.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eaef8db28cb6e4cacfdd5951db3a1fa82d2975173815805e22ba923bcd4a1bbc',
     armv7l: 'eaef8db28cb6e4cacfdd5951db3a1fa82d2975173815805e22ba923bcd4a1bbc',
       i686: 'e745b1df04b876d46058f97e4b0f0825366e7c31fa9fcdaccca9720024ed2842',
     x86_64: '2239b87d20e981ac9175cca044336580b2c155f2cc1cad295bb211ba4078395d'
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
