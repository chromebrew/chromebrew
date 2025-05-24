require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.152.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7785ccfeca4863f9ff865df368951156641101a449f548604e5eef934288482',
     armv7l: 'f7785ccfeca4863f9ff865df368951156641101a449f548604e5eef934288482',
       i686: '613f40babdab0f8684dfaaf9529f9eb78aa13d201c313a02677247883eacce44',
     x86_64: 'b73ac7d0f027eb4f5bcdf967270db53e128ce18dd48adc838fca97380484669a'
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
