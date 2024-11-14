require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.138.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '00cf4fca520040c729c9d61d21d1a24ba625ba538f8c304a7d5a3c1344a4d790',
     armv7l: '00cf4fca520040c729c9d61d21d1a24ba625ba538f8c304a7d5a3c1344a4d790',
       i686: '611ea53b9c425c12ae211db5baa52da69a9ea65cfaedc1e9988af261139563fd',
     x86_64: '4ecdf07501ab743d19eeffc8d9ecd9a5de8353872395e68416f1c819d2f3d507'
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
