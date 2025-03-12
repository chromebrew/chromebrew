require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.25.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0914d5b6ab195c855f46a5757e1190a3db8a4d41a216d247ca757984724e3e33',
     armv7l: '0914d5b6ab195c855f46a5757e1190a3db8a4d41a216d247ca757984724e3e33',
       i686: '7cfc9facb3cf68e913478dc166551673860b97bdb1779ca00da750759b72f1c7',
     x86_64: 'e8a3cfa147707c549632ef6975381ff2e39749563338346a08b94d04a13e88d8'
  })

  depends_on 'python3' => :build

  no_source_build
end
