require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.168.3-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '72e1057a4ea2074591bddd2b0eadcbda0385709aa6214fe624ddf58983f2c535',
     armv7l: '72e1057a4ea2074591bddd2b0eadcbda0385709aa6214fe624ddf58983f2c535',
       i686: '5549e2a5d64ae1f98f04415cebc173b973cdb80de0eefc08600ea50355fca684',
     x86_64: 'b5ff1ee4a31fa01d8430e95e3e072a9bde82d0c2b4e699bbe42cc27079f7b3cc'
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
