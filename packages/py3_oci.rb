require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.169.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '64cd8f06142d749d6e1dad77ec9d5d44ea1467ffe9f80ad6efc870383f874f44',
     armv7l: '64cd8f06142d749d6e1dad77ec9d5d44ea1467ffe9f80ad6efc870383f874f44',
       i686: '817935454c6a0bb78b78dd030c24db9df3f8740217b2d9494a861e02d06ebdc8',
     x86_64: 'c1da0110c6421736f3b5393aa8f3af1396c668dd5664fdd94bfcfba9513c566c'
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
