require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version "2.181.1-#{CREW_PY_VER}"
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '67f17272e3cba1d3b22b0b6de903fd233d81d1b02cc19b2bd4457cce0275323d',
     armv7l: '67f17272e3cba1d3b22b0b6de903fd233d81d1b02cc19b2bd4457cce0275323d',
       i686: 'be2099309811b9d02babdfd4cd053f59edd10a07b30a95f7fc3c214cc79e646f',
     x86_64: '661a880e736a0f0559117d48442a5cd0763d096cf980f4eb7c112f4f03fcaf8c'
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
