require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.165.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd5f5311fddcd4891c842cdb363aacc14906346714d9859197514c46b1bcd5198',
     armv7l: 'd5f5311fddcd4891c842cdb363aacc14906346714d9859197514c46b1bcd5198',
       i686: 'b265ae6d98c5993b67944a2f1bafdc2b5a3764a1761c145fc3f5c6f7a3dec671',
     x86_64: 'b5611a1c6e6e9ca9fbcf4e09efaca98b0adc521af5d2d9b8b61a93adf504728a'
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
