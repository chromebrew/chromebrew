require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.139.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd2fce622e27f1176f759f715e5ba7c82adcbd2101807bda67adb68f187e6f782',
     armv7l: 'd2fce622e27f1176f759f715e5ba7c82adcbd2101807bda67adb68f187e6f782',
       i686: '366a9b8ec696a2ba1e42a17e0d790e06445afaa0aae4089883892d29cd3f0d47',
     x86_64: 'da8f404d72ec95d8dcd556652b99d8f7537b3e48f2803bf802eda2946191967f'
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
