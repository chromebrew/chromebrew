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
    aarch64: 'aa25e146ee17ac536a0f230ebd8d490845f166a260ed461c80e908dfdd508394',
     armv7l: 'aa25e146ee17ac536a0f230ebd8d490845f166a260ed461c80e908dfdd508394',
       i686: '11524de3d8aed19d26a5e9d1e92ebd24a93992f2e98b05dbb1c4630942e95c4b',
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
