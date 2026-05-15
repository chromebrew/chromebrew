require 'buildsystems/pip'

class Py3_requests < Pip
  description 'Requests is a simple, yet elegant, HTTP library.'
  homepage 'https://docs.python-requests.org/'
  version "2.34.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea4311726262024efcf0e1242eb0fa6dcad96d400b67aeea122c7be60e1ea1cb',
     armv7l: 'ea4311726262024efcf0e1242eb0fa6dcad96d400b67aeea122c7be60e1ea1cb',
       i686: 'd0202b15e43e3e9f8dcec6833666660117edc2d2414951c3f1a5e9934a6aa9a0',
     x86_64: '273a55203c94eb2ce8136e3014f46aea584b8871e14f90311a009d8e67662bfb'
  })

  depends_on 'py3_charset_normalizer'
  depends_on 'py3_idna'
  depends_on 'py3_urllib3'
  depends_on 'python3' => :logical

  no_source_build
end
