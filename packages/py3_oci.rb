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
       i686: '3c932d9591b6f6dda66b987262e2d02ce5e4491263f9ebdd3d65d101286d0911',
     x86_64: '63d64c727824b4042184b9b40935d1367d7309138c169a1f87367e1a71382ba8'
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
