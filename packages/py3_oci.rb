require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.175.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '487d45a0d2e64fe74daadda0c85d12f9e541572571783209cef4761b49958200',
     armv7l: '487d45a0d2e64fe74daadda0c85d12f9e541572571783209cef4761b49958200',
       i686: '5020517125850a6e306425112da7acf12241d5dc382c47a6696f98e587a22c06',
     x86_64: 'bef55c8c3bcee5151ce87f1dcbbfbb129e9c33c8fc331dee4ffa5b89cb1c9fc2'
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
