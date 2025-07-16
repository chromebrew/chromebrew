require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.155.2-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '72f6acde4bcf5ccd397f9ae18493eaa4f7c4eb8051c0f8ca889d73ab88dc9627',
     armv7l: '72f6acde4bcf5ccd397f9ae18493eaa4f7c4eb8051c0f8ca889d73ab88dc9627',
       i686: 'd728bac615477c5c47daa16feb697194f17d8027c6ed9d7e828e373ce219c924',
     x86_64: 'cd794eed853757863edf25287aacbf7a21eeca69104fcf9facc1ef0ea9e16a7a'
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
