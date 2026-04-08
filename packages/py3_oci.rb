require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.170.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8dd68054557822f0979c0ece5b2265360d678c712a15b5aa0cf624cd9dd7b855',
     armv7l: '8dd68054557822f0979c0ece5b2265360d678c712a15b5aa0cf624cd9dd7b855',
       i686: 'e177c9be4d4c4aaa031a8038d5f6cf62c55b18e0fa40ae4d9043bd68675933d7',
     x86_64: 'aa1e82cdc3b74b9645055da92213f3df465e0a43e9984a8169486737bb22e7a5'
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
