require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.142.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '987d6649067b1fef193791f77ae290194ab496dd066fdeb8429716fa8fa53525',
     armv7l: '987d6649067b1fef193791f77ae290194ab496dd066fdeb8429716fa8fa53525',
       i686: 'eb6eafdaee5cb444aacef1e414b733384aeabed77d1bda4eddf334cd313cbe77',
     x86_64: '2cc6ae1d7d5e29fa5c2b42dccd59869607e5b8e344148bf52c82238e04352575'
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
