require 'buildsystems/pip'

class Py3_requests < Pip
  description 'Requests is a simple, yet elegant, HTTP library.'
  homepage 'https://docs.python-requests.org/'
  version "2.33.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '91948fb3b025e888d0315959c1a3541a17d407be49a39d305a2fb512f5a7d75f',
     armv7l: '91948fb3b025e888d0315959c1a3541a17d407be49a39d305a2fb512f5a7d75f',
       i686: '448e577aed2f8908834b09e4165ebdb29a73f309c3ddfd4b6284d8161ab6c856',
     x86_64: 'e905fac91e6231860b4e97ddb47befbd3a603da872448aaabb2521a63109f863'
  })

  depends_on 'py3_chardet'
  depends_on 'py3_idna'
  depends_on 'py3_urllib3'
  depends_on 'python3' => :logical

  no_source_build
end
