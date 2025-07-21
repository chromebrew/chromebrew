require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.28.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ce7a213b371a7609f842a756c81869a1c0cc64c505bca183adfc73ad27707930',
     armv7l: 'ce7a213b371a7609f842a756c81869a1c0cc64c505bca183adfc73ad27707930',
       i686: 'b220c3fabc56eddbf934c4c2158a8c2b8baa79a8ac2f8efe802abb3aced06a8e',
     x86_64: 'bc37647435098784e16eabc028fdfbbc81025a96d1c1a4f437c7055579f41997'
  })

  depends_on 'python3' => :build

  no_source_build
end
