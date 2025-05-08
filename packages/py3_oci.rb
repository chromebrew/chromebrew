require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.151.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7c92bc29c4d75ffe0383bbb87c788213668ac8f05f354c12c2036ab2242d537',
     armv7l: 'b7c92bc29c4d75ffe0383bbb87c788213668ac8f05f354c12c2036ab2242d537',
       i686: '2b08348034f6babe56a1488eee2653d0732f1b557a4a50597f54ab21c5988068',
     x86_64: 'b2531e165cf91361e75edfa328e0ee0f696d16b628ce73c3ade8170d90943780'
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
