require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.157.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '68a568aa73143982eaca6fd8bf3f33f04e099476ca643d6e81d0db540a8623c4',
     armv7l: '68a568aa73143982eaca6fd8bf3f33f04e099476ca643d6e81d0db540a8623c4',
       i686: '09cf0825437fd718d3f919002c5a2e2520ffae9d26a56973edb264359da3097b',
     x86_64: '021b21cd425569c5cfacb3e8fb1c1ffcc7ff346799b7579340321ca05de72af8'
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
