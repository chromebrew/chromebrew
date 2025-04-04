require 'buildsystems/pip'

class Py3_argcomplete < Pip
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  version "3.6.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a14f38bf80acbcc40807424f3d25bd54429573de88cd5aed5c2627a575ae8822',
     armv7l: 'a14f38bf80acbcc40807424f3d25bd54429573de88cd5aed5c2627a575ae8822',
       i686: 'a1d60368e7fba6be696c534bbc66d6b1e79f521f982154dec4761f5562c83ef2',
     x86_64: '9c6c6766995470f21285e50a10501ed734444156b96591196b9dc6830c19d14c'
  })

  depends_on 'python3' => :build

  no_source_build
end
