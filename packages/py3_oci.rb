require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.177.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8dd74700b6e19213c56011a0c3dcf902f742aa4e0b4407670aa3eaae55b26e0c',
     armv7l: '8dd74700b6e19213c56011a0c3dcf902f742aa4e0b4407670aa3eaae55b26e0c',
       i686: 'faa2c51c0445f4ddda301cc0b95064b99cebd89c6bccb3291a774fea59145a86',
     x86_64: '9a3ecdb3a0febc76716af821f45d735d0ca2a107e3984d54d14face7e85fe822'
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
