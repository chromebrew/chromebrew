require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.158.0-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9466dd5b304d960f293dd6cc5612a42bab72e86d57e727314c9eab71d61db52e',
     armv7l: '9466dd5b304d960f293dd6cc5612a42bab72e86d57e727314c9eab71d61db52e',
       i686: '6e804b0fa59bbd7ee778017e905d4bf1ff46f47bc2bbd5009934f081bac34d91',
     x86_64: 'd0efe6f8d56c7f1c96b01a7921b29a68e7827c06d76952e1c7a5d62a5b49a15a'
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
