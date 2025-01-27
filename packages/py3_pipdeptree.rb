require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.25.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85d5ebd584760dd4552719544e3df90ad84c80fa0fd4c8a5031b44a824503036',
     armv7l: '85d5ebd584760dd4552719544e3df90ad84c80fa0fd4c8a5031b44a824503036',
       i686: '29d51715097a9e03f91cd0015d1bf642aaf8c892f7181d956f77d82c57db82d7',
     x86_64: '1bda2398e3b0b34ed1509f17af34c35e92ac1d8957dac4743a24da35143b2ed2'
  })

  depends_on 'python3' => :build

  no_source_build
end
