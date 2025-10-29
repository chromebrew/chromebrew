require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.162.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c50d8ddade9ab89d57318ff4a127b8920acf4f386655c551ee7e63a955ae7c41',
     armv7l: 'c50d8ddade9ab89d57318ff4a127b8920acf4f386655c551ee7e63a955ae7c41',
       i686: '94fc7dc70a0617c9448ed9b3846a06d2f8a6d24acb5e396b7251089fb64cb7f7',
     x86_64: '047efc82d8ade5e8bd6eb6c16e7df21db21c56591e78b2d87e5db680caed5d20'
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
