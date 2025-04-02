require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.149.2-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5fa3492dda42b2bd0c16b8da8d2f1499e401b68107c8b3d241f3f283b8e75fab',
     armv7l: '5fa3492dda42b2bd0c16b8da8d2f1499e401b68107c8b3d241f3f283b8e75fab',
       i686: '9def84b8f5bc9e2fcd4b22368b9d2e87be7951807dbfad8f68a12a42e66c0e88',
     x86_64: 'cfb73a265b380605af7766c788cff24c60f422470f4c5ac020a931f893dbb6bb'
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
