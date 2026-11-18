require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.192.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '07f65bd7f67e1c7014be0bf7e156e00f98fe5f25e6486b82c208e31a9afbd99c',
     armv7l: '07f65bd7f67e1c7014be0bf7e156e00f98fe5f25e6486b82c208e31a9afbd99c',
       i686: '2fdb7c27583f1ca1a3db663657b4a79e95bcccd1c81adc7abb154f073721dfe2',
     x86_64: 'd81603597ad35b74fb669767fba3a778c16c35bf32717ea6a4848e74d702b877'
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
