require 'buildsystems/pip'

class Py3_argcomplete < Pip
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  version "3.7.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d86abc9478c75b81445f2dc2ae62b7d81855ddba0b22d10446d2b1456d849c7',
     armv7l: '1d86abc9478c75b81445f2dc2ae62b7d81855ddba0b22d10446d2b1456d849c7',
       i686: '1107241814e77924b188381e11edc79ca8aa531b6a60992fab068b47c67fc84c',
     x86_64: '38106bd54bdd1170f1c3a1f912695d7907c10b96a9e04d93f31ccaa00aacc58a'
  })

  depends_on 'python3' => :logical

  no_source_build
end
