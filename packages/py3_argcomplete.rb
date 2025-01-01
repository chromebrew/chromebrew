require 'buildsystems/pip'

class Py3_argcomplete < Pip
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  version "3.5.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec1038917be7b87c8685244a639f88aa2e0b291efc989f2d594d46cd439a4f6f',
     armv7l: 'ec1038917be7b87c8685244a639f88aa2e0b291efc989f2d594d46cd439a4f6f',
       i686: '887aacf879741c85d1f8d18cd4c16ab615a1836cf9df3375e179194ceb9c2cf9',
     x86_64: '2409fc468c69a30e46009bce8e51476ba46c4f59add289cd2a5e0e0e57c83940'
  })

  depends_on 'python3' => :build

  no_source_build
end
