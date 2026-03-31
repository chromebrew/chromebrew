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
    aarch64: 'cf07948bfd5528c99001da7fb1179598c6abf0f2e4d0ef476b85e3c2fba80faa',
     armv7l: 'cf07948bfd5528c99001da7fb1179598c6abf0f2e4d0ef476b85e3c2fba80faa',
       i686: 'e9092a69de6ef04b87dd33778eb68fd5f9fded53a224861e905e5b9cb8ae46df',
     x86_64: '86f19fa9acb268142dfefc2d21393056f643498c24bf87b1cccdad2a19f3fde1'
  })

  depends_on 'py3_chardet'
  depends_on 'py3_idna'
  depends_on 'py3_urllib3'
  depends_on 'python3' => :logical

  no_source_build
end
