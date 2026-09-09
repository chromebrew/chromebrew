require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.185.2-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21885733f398fe26f1a6d3f81610fdca2043d5ddb8c3a20891f17c3d2713e022',
     armv7l: '21885733f398fe26f1a6d3f81610fdca2043d5ddb8c3a20891f17c3d2713e022',
       i686: '65f383e8098263654ebae5e515bb0d6f7edfd6d6566a35834d64ffb2ad661b5b',
     x86_64: '6c691b6b9d41d4608fb29b0169c401fba7bf6bac73f649936974555a237eb632'
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
