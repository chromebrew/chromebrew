require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.2.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5bc664928e39650896ee9bc7a8b7b46609d9bb00c48e618105999b688af271c7',
     armv7l: '5bc664928e39650896ee9bc7a8b7b46609d9bb00c48e618105999b688af271c7',
       i686: '8b3c61150f855e2f911c947c2b8dd5c3ae112d8a28f589285a60a24de00e4041',
     x86_64: '3f5f20d09e1bcd56609a2c2d20e9711394ce81e27366d47b943a9c1d36fa7e9f'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
