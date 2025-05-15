require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.152.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7785ccfeca4863f9ff865df368951156641101a449f548604e5eef934288482',
     armv7l: 'f7785ccfeca4863f9ff865df368951156641101a449f548604e5eef934288482',
       i686: '5e1f6b9e8eb5f68a0774a646e5515dfada3ea5154fdb20e6dd04eba0f40e3fde',
     x86_64: 'f652dd3bb4c9fb2ac70ec19cdac4584e686992eb4b4c50777910413af97e81bf'
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
