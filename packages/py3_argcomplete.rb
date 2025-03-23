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
    aarch64: 'a14f38bf80acbcc40807424f3d25bd54429573de88cd5aed5c2627a575ae8822',
     armv7l: 'a14f38bf80acbcc40807424f3d25bd54429573de88cd5aed5c2627a575ae8822',
       i686: '4fc1402f7cdaf1aa8de115098dcdb8753bcbd0aa04316c003f0c6800825c30e2',
     x86_64: '946e41da2888ca1e4ddb17dfc3f59541ef5b956129b0dc299e878c67eaab122f'
  })

  depends_on 'python3' => :build

  no_source_build
end
