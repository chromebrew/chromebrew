require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2026.11.20-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7718cd5f8c3041b1d2178d7931d842591c899813349cf54788ecdbba7bbf1570',
     armv7l: '7718cd5f8c3041b1d2178d7931d842591c899813349cf54788ecdbba7bbf1570',
       i686: '58fda53fc14855945456e238d34db0cfd83e52f6038b3e8dd0d0f015b9aca8fe',
     x86_64: 'dd2aa28bb4e0f7e14bad31f42ba8bb83c44c75a85cfa309f40c6dc8692d2e27e'
  })

  depends_on 'python3' => :logical

  no_source_build
end
