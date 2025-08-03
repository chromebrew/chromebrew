require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2025.8.3-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bb8d6f9973e7b910a3ee60a8b2328fdcb563d073f10fe8c5aaeba5a298c63cbc',
     armv7l: 'bb8d6f9973e7b910a3ee60a8b2328fdcb563d073f10fe8c5aaeba5a298c63cbc',
       i686: '816a16618ee1945cd69f60e529501b03d54a8c8feb4ab977505cb446a04c2a82',
     x86_64: '5b3d84c0dd9175a17505bf5e16e6fbbb948595b49d5feae9fe9afa46e597cb7b'
  })

  depends_on 'python3' # L

  no_source_build
end
