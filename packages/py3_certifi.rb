require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2025.7.9-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5b6e63821766f9ee60a350861ef952a7e61f7dc89ad29208ae455150b37a8cdb',
     armv7l: '5b6e63821766f9ee60a350861ef952a7e61f7dc89ad29208ae455150b37a8cdb',
       i686: '7599feb4c49c7c2477d4d4ad1171916590d29abe305ae51ed9b33db018a4aecc',
     x86_64: 'e6fc97d137812f0f97adef604641171ffc263ff31a06bb3af3b582a6097ed76c'
  })

  depends_on 'python3' # L

  no_source_build
end
