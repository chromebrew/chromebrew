require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2025.11.12-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e82cc7f36ef3742e337097d63abbe840d6cb374fa45d0e4e2a6485d96ce6c593',
     armv7l: 'e82cc7f36ef3742e337097d63abbe840d6cb374fa45d0e4e2a6485d96ce6c593',
       i686: 'c23b48b0bff7a17d9ba8b633ee6f59036619a689ebc67894cab1f796d4e34158',
     x86_64: 'b6018d96ef4c24fc5fa3de02cc79d230a1a382903cb782907410279cb57f0421'
  })

  depends_on 'python3' # L

  no_source_build
end
