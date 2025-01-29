require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.143.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5626394abf02e15c2057ca64bb294776f4f485c127440274a989c8f560c2cb0e',
     armv7l: '5626394abf02e15c2057ca64bb294776f4f485c127440274a989c8f560c2cb0e',
       i686: '471e3e6f744e3f058f938bf5bd230b06b0436f430c2708bcf2c13e682cc79d7a',
     x86_64: '9396c1008af6c993d2808a0e60db6472c89eb529ee781724852b6522169c2fe1'
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
