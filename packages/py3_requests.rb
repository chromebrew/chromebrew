require 'buildsystems/pip'

class Py3_requests < Pip
  description 'Requests is a simple, yet elegant, HTTP library.'
  homepage 'https://docs.python-requests.org/'
  version "2.32.5-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_chardet'
  depends_on 'py3_idna'
  depends_on 'py3_urllib3'
  depends_on 'python3' => :build

  no_compile_needed
end
