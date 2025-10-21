require 'buildsystems/pip'

class Py3_argcomplete < Pip
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  version "3.6.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f5368583e9d696d1e9e13e6427fd2710adfa2603506b119552ca6fe8c4e9a8aa',
     armv7l: 'f5368583e9d696d1e9e13e6427fd2710adfa2603506b119552ca6fe8c4e9a8aa',
       i686: '9ae813fd0bc6e4b0f1cfdaf500204228b8964d67c83952c8801ec968ea117a8b',
     x86_64: '5946db723d03d7c882833d86876e0c8dfea8a7824559de692155eb2012097578'
  })

  depends_on 'python3' => :build

  no_source_build
end
