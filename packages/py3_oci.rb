require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.135.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50f84d85e4a8e912824fc1df40cfd45a88fb579e9eb8315ead0c43c4905b3821',
     armv7l: '50f84d85e4a8e912824fc1df40cfd45a88fb579e9eb8315ead0c43c4905b3821',
       i686: '8a5345e26fae95c517545800448a8fdd39dc7d7d6cc331380a506d29367a2792',
     x86_64: '6f877ddbdb0ac78378222b7a97580d434b6aefa5bb498bbd7efb57cd31bb4919'
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
