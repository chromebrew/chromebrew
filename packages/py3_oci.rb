require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.171.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80dd3cd69dc9fdea52874b764ea876390715a26a906081bd28e35c7f08a43a14',
     armv7l: '80dd3cd69dc9fdea52874b764ea876390715a26a906081bd28e35c7f08a43a14',
       i686: '4d8edef563d55d6538993ae328edbfc1216f9803c347797a920771cef41e4528',
     x86_64: 'd21a451e6e9db4a7e90b58f6a4aa12db59154415027224893f03f5293d1dfb74'
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
