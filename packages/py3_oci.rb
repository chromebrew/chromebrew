require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.193.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '164f7f912bb82fdf50fd00923cc7d4a3888dbab069250c13851a4fb5406fe074',
     armv7l: '164f7f912bb82fdf50fd00923cc7d4a3888dbab069250c13851a4fb5406fe074',
       i686: 'bb3108f3f14ad048f705e53d07ecafb337ae729608e819b150252cc24b65e117',
     x86_64: '63c355868f2f62ed2fc54bc839f62088a737de40a57257547fb2ff445b8a43cd'
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
