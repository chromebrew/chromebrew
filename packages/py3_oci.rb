require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.180.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c19f1de432941969eb5a539e53ecbf8c4cb5721852b4d55830cd3f6bb9585f97',
     armv7l: 'c19f1de432941969eb5a539e53ecbf8c4cb5721852b4d55830cd3f6bb9585f97',
       i686: '012b32bb0d64cc9f48c02221b247ae29fc45d09dcb5dff51f6b32a0733cbf5b1',
     x86_64: '4f337459fd9d16cf21396b98a81d55e8e90eb9aaba155a0674ca6488b2b7f7f1'
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
