require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.155.2-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2b5471070073b9432955b2b40279bea38085d2e63ffdd0a2b24e2f28c0ebe9ad',
     armv7l: '2b5471070073b9432955b2b40279bea38085d2e63ffdd0a2b24e2f28c0ebe9ad',
       i686: 'd728bac615477c5c47daa16feb697194f17d8027c6ed9d7e828e373ce219c924',
     x86_64: '73c353ef29ff51092028cd16ea85ceb9516207b1ad0e157fbd088d3128241d5f'
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
