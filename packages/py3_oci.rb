require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.141.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2fe02e3dd328e0f345ccd99f9b075ae725abf83dd0789a45f136900c6b885877',
     armv7l: '2fe02e3dd328e0f345ccd99f9b075ae725abf83dd0789a45f136900c6b885877',
       i686: '8cc9be90914dea8ecdee4d33727a9305a5a805d96de8f473a39a13d247bc126e',
     x86_64: 'dba59a886c0b935ed6df905cc29dc2555d8ea470f49fd320e1777a73eb2bfa15'
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
