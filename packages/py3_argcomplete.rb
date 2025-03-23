require 'buildsystems/pip'

class Py3_argcomplete < Pip
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  version "3.6.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c401edf43a57f5f110f6065fcc37fb4deae0c252be950816c274a3a1234e3776',
     armv7l: 'c401edf43a57f5f110f6065fcc37fb4deae0c252be950816c274a3a1234e3776',
       i686: '89b19fce7df9041284417c4e41a66eab742d4a796f58d102e8741cfbeb5d1456',
     x86_64: 'c3c681538878f3fdce6e8e1a5f702fbc85d951da988dc327ebff176e5263e2d5'
  })

  depends_on 'python3' => :build

  no_source_build
end
