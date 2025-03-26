require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.149.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '49df3239ddf8f06c22f785052d11b6ab89df3c562b72d1232d038928f5df4d3f',
     armv7l: '49df3239ddf8f06c22f785052d11b6ab89df3c562b72d1232d038928f5df4d3f',
       i686: '9def84b8f5bc9e2fcd4b22368b9d2e87be7951807dbfad8f68a12a42e66c0e88',
     x86_64: '2044d066e650a2d685d3fab8a902f0e5dc4fa2b47bb80f87f003c3ab9c94fd6b'
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
