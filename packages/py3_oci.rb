require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version '2.135.0-py3.12'
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6b55846564ae0c53c328b781a179a66f72e6e486853384b8dfe33f019af5067',
     armv7l: 'a6b55846564ae0c53c328b781a179a66f72e6e486853384b8dfe33f019af5067',
       i686: '3a50ea19822b6b96dfbdd60e67cb4183b00810b1bf1bfbe2f479432cfb403d8a',
     x86_64: 'dcbb849bdc7814214534baaa41b309e3861d3e76614b45266e2ca5c437de5ac4'
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
