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
    aarch64: '035b79ad1e22d1397294f9c148a853dddec5e5763c3abbb10f7a3e8603a446e4',
     armv7l: '035b79ad1e22d1397294f9c148a853dddec5e5763c3abbb10f7a3e8603a446e4',
       i686: '7cfc9facb3cf68e913478dc166551673860b97bdb1779ca00da750759b72f1c7',
     x86_64: 'e8a3cfa147707c549632ef6975381ff2e39749563338346a08b94d04a13e88d8'
  })

  depends_on 'python3' => :build

  no_source_build
end
