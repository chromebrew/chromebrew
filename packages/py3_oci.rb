require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.189.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6dda8385c3be8aa943d2732b57f5130a422e37423b339c6de794a4a636658fa',
     armv7l: 'a6dda8385c3be8aa943d2732b57f5130a422e37423b339c6de794a4a636658fa',
       i686: '67e9cffe66299fcd84f72b49f0021596fe783ad0c602dd996b587c586867d8fe',
     x86_64: 'e792580ec42b363655c4791285d4ff3e63f24cf37e6dbaa0c1e7d4f3fe6bcab6'
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
