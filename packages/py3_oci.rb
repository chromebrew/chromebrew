require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.157.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '68a568aa73143982eaca6fd8bf3f33f04e099476ca643d6e81d0db540a8623c4',
     armv7l: '68a568aa73143982eaca6fd8bf3f33f04e099476ca643d6e81d0db540a8623c4',
       i686: 'a2af0ea2ef4a5de1aa70a35045b08839f63a233440eccff769ab87bbf45d2c3a',
     x86_64: '0e9b67431b53f574171057a64e9fb6964437ad11c07e5f4fd27b5d7e00dfc45f'
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
