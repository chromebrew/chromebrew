require 'buildsystems/pip'

class Py3_argcomplete < Pip
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  version "3.5.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec1038917be7b87c8685244a639f88aa2e0b291efc989f2d594d46cd439a4f6f',
     armv7l: 'ec1038917be7b87c8685244a639f88aa2e0b291efc989f2d594d46cd439a4f6f',
       i686: '1baf35d3a3b0b7ab9634a345831860d2484b9d1a22859742fb709d8d846ca401',
     x86_64: '2409fc468c69a30e46009bce8e51476ba46c4f59add289cd2a5e0e0e57c83940'
  })

  depends_on 'python3' => :build

  no_source_build
end
