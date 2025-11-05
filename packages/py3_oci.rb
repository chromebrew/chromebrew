require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.163.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9aa2ba04a80fd7790a2321325b9df96455acd1fd7d7f82cc12bddf9edb1fac9c',
     armv7l: '9aa2ba04a80fd7790a2321325b9df96455acd1fd7d7f82cc12bddf9edb1fac9c',
       i686: '73ace75b36defc35669b56749f1a8a1f8e67a3cc84cff4e439c09b7e232780e5',
     x86_64: '33688c38aa34ad935bcd94558fbd874a8ca4dd53cb5cb5a6ac8c6b1df77ae7b7'
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
