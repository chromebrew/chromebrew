require 'buildsystems/pip'

class Py3_hatch_fancy_pypi_readme < Pip
  description 'MIT-licensed metadata plugin for Hatch'
  homepage 'https://github.com/hynek/hatch-fancy-pypi-readme'
  version "25.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea53a5e30319540e2f7cdb31eabe2eb3a0ee0ae8f1a6ea86027f221359c0187f',
     armv7l: 'ea53a5e30319540e2f7cdb31eabe2eb3a0ee0ae8f1a6ea86027f221359c0187f',
       i686: '7cbc55d236d3fa66b5a1220b6528c4612019e279aead86b4dc276ca94a0cc903',
     x86_64: 'af276df57aeeb5327d3fa857af901da951ae1d20944c5edb8bff639db4569d94'
  })

  depends_on 'py3_hatch_vcs' => :build
  depends_on 'python3' => :build

  no_source_build
end
