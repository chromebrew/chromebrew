require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.181.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bc8529f844a30f149a7fdc8ec93edca25e373d444186ec92a335fc17b7d8f540',
     armv7l: 'bc8529f844a30f149a7fdc8ec93edca25e373d444186ec92a335fc17b7d8f540',
       i686: '61f1021cd9db90dd8a350f6b4d617ba76b3ae4b074f650edb50a973f4d25897b',
     x86_64: '4ccd9ce72415d9cfa820b8784054ee9890daf424fce698e24e0def57210e5ee0'
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
