require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.172.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa7db9d56cc7927e2b774885631ee43edae1819193a25a41c71cbf158ea82747',
     armv7l: 'aa7db9d56cc7927e2b774885631ee43edae1819193a25a41c71cbf158ea82747',
       i686: 'ea66ba3783de59f052c66fc044baf50a238c566767081661638553b9f7a0270c',
     x86_64: '6d92448823715d1f551b8fdbd7e6930f4aff090f3f42bc1d31727e3ffb29fb57'
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
