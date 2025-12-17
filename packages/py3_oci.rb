require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.164.2-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40aeffc852cacf1249f5909f96e435a62566203f4f644079b7b8b5ca2c368669',
     armv7l: '40aeffc852cacf1249f5909f96e435a62566203f4f644079b7b8b5ca2c368669',
       i686: 'd5d85ead49142e9558b3c250d208a9e9358a57ac95185ae42b0001e7d1e65da1',
     x86_64: 'b920fbb62cdb826fb77d44000ab804e3d4f75da19e7a0245e64cebb7a552ee1e'
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
