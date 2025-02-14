require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.144.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ca75e61446f60f6602b70b6b9dad3b5786452502a1c5f1fbcf47a55b82f81a1',
     armv7l: '1ca75e61446f60f6602b70b6b9dad3b5786452502a1c5f1fbcf47a55b82f81a1',
       i686: 'd9ba76f7c96762f3daca384baf5045672446dbcc0e8ec0524c6fdfddd9afa63b',
     x86_64: 'e027c90620816f0b9ae9627cad2367da6946e0a4c8c4211c95cab60e23d4718e'
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
