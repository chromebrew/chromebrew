require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.173.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fbd69c2cf6a34ffd7519130bbbdb406873f376517735bc0332bcd27f2c8a15b7',
     armv7l: 'fbd69c2cf6a34ffd7519130bbbdb406873f376517735bc0332bcd27f2c8a15b7',
       i686: '6a5914e7290a641ca14e5c4b05e154a8ee31c96483560ef45aef1b199f64f368',
     x86_64: '222d1742a6a84c18df04fec6d63d1f019c493dd50929cc55c84dfcf8205f13fb'
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
