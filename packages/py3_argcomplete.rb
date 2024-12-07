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
    aarch64: 'c6d3d5b5f5e5f37568c77044d28f6ff5e9a63aaaf98c48c61f29415681467da1',
     armv7l: 'c6d3d5b5f5e5f37568c77044d28f6ff5e9a63aaaf98c48c61f29415681467da1',
       i686: '1baf35d3a3b0b7ab9634a345831860d2484b9d1a22859742fb709d8d846ca401',
     x86_64: '2409fc468c69a30e46009bce8e51476ba46c4f59add289cd2a5e0e0e57c83940'
  })

  depends_on 'python3' => :build

  no_source_build
end
