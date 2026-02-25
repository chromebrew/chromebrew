require 'buildsystems/pip'

class Py3_osrf_pycommon < Pip
  description 'Commonly needed Python modules, used by Python software developed at OSRF'
  homepage 'http://osrf-pycommon.readthedocs.org/'
  version "2.0.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a912e99b66f6d8c370397b07d65fed1c56b5e5ebd19b54644a8ba9e4512dd2f',
     armv7l: '4a912e99b66f6d8c370397b07d65fed1c56b5e5ebd19b54644a8ba9e4512dd2f',
       i686: 'ffab8d086ea223d10607daaad60c887a17777f6039753497ef110ad3b39203e5',
     x86_64: '668ccfc35248b38ddd404a110a8e93a854411239c46d5c4f372a20353744e87a'
  })

  depends_on 'python3' => :build

  no_source_build
end
