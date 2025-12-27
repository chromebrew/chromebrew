require 'buildsystems/pip'

class Py3_requests < Pip
  description 'Requests is a simple, yet elegant, HTTP library.'
  homepage 'https://docs.python-requests.org/'
  version "2.32.5-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6dbb0d15057932a172c35543ab604bbbe7e48a1362e2bd51f22df9e23246fb91',
     armv7l: '6dbb0d15057932a172c35543ab604bbbe7e48a1362e2bd51f22df9e23246fb91',
       i686: '6a36ca8d1c7bd7a2b23a301e6dbfb74da60c27c9c5197081ff4c6a1559e49e41',
     x86_64: '807d53dc83b38e149dcd532b435b9c618c370990488f7fc6f533e78745dd788c'
  })

  depends_on 'py3_chardet'
  depends_on 'py3_idna'
  depends_on 'py3_urllib3'
  depends_on 'python3' => :build

  no_source_build
end
