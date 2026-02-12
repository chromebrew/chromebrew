require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.167.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '24bf0551d23cf9d59140ad5df9821f476bb50e6c700df16c3ab684d8dd11ae7f',
     armv7l: '24bf0551d23cf9d59140ad5df9821f476bb50e6c700df16c3ab684d8dd11ae7f',
       i686: '11102b6eab69ea421650856e8b68de57952613ec3d4b199e549b8541791faf02',
     x86_64: 'b225bb4d861452f35d91264045dcf3bfd254a2b9307bc7773d7d868047bab624'
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
