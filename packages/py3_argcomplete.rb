require 'buildsystems/pip'

class Py3_argcomplete < Pip
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  version "3.6.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2eb07d1c75fb7a5318b8da2493e7d6a034ffbc0d3be0de4e9d5f89dffc46d9bf',
     armv7l: '2eb07d1c75fb7a5318b8da2493e7d6a034ffbc0d3be0de4e9d5f89dffc46d9bf',
       i686: '887aacf879741c85d1f8d18cd4c16ab615a1836cf9df3375e179194ceb9c2cf9',
     x86_64: '095bde7c1e10da06ebb3d0396c161fba3b1542a52f54596dfdeff48708419ab4'
  })

  depends_on 'python3' => :build

  no_source_build
end
