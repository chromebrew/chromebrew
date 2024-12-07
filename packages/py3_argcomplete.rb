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
       i686: 'd7a180a5b7ddc040c4e5ea8f8506a4dc46fc557e656ab0df557529f8849db39c',
     x86_64: 'b594d8dac1ec5f30fef65d7bc45f839e5e8908c5a2a4c0481341641a88c6e636'
  })

  depends_on 'python3' => :build

  no_source_build
end
