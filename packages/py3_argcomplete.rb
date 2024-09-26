require 'buildsystems/pip'

class Py3_argcomplete < Pip
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  version "3.5.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a09fb37c79b418313f30ad2e6cafcaf0875bc4c8c45c53d03c830ece1668e23c',
     armv7l: 'a09fb37c79b418313f30ad2e6cafcaf0875bc4c8c45c53d03c830ece1668e23c',
       i686: '8b07bd1c8cc47d7607b59e359760e75bcc3e4d560d7924c6d4e535cd1e8eab8f',
     x86_64: '32e5a434c319e53496d0cacb8913553e367a6b845b10e60b761c75cdcc22ea49'
  })

  depends_on 'python3' => :build

  no_source_build
end
