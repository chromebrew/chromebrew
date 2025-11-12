require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.163.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '31d6445175230c9d2b01439e5e6bdd5c12325a9f74ffcc44ae53c32c1accef93',
     armv7l: '31d6445175230c9d2b01439e5e6bdd5c12325a9f74ffcc44ae53c32c1accef93',
       i686: '6715ef91b926411e2f98b7f9cdaa88e42f6a8c36dc8435995daf83c4267ce62f',
     x86_64: '12d99140a89fe3b110425a36e4352f5d8f9a436633aa6755d29041b1ee28a5a4'
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
