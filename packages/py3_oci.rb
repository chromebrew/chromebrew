require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.159.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '83ee14ad4be2ed0d05ec048a752dce1c0446b74f1fccbab3eef7920ca00ee7b5',
     armv7l: '83ee14ad4be2ed0d05ec048a752dce1c0446b74f1fccbab3eef7920ca00ee7b5',
       i686: '43ba30f7880adbaad5b5a53e155a30e730335907a5dd18e7ddd1cff3013fc5d0',
     x86_64: 'a3cf0c54cdb8499256198dd1f55a6e599563fc62c7e12f640e6ac00ad9fbe611'
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
