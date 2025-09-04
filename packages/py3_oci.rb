require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.159.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40e4e8bc10ce421df332a3900480bdc13dd2e64bd9b8f01c017c8936d383ee02',
     armv7l: '40e4e8bc10ce421df332a3900480bdc13dd2e64bd9b8f01c017c8936d383ee02',
       i686: '388e19cd557eaf2182d1bdd1069e9b1ca6f9dbee0926c2d613ae52e12324e2ad',
     x86_64: 'efcad2068373fb4e9dc2b26bd4201de0a81c449f4365d9cc4e336ae37c94f1c5'
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
