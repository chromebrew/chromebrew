require 'buildsystems/pip'

class Py3_argcomplete < Pip
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  version "3.8.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc71895b43658dfe8d06de20916ac60c56cc188917152d4daebea672ecf68e8a',
     armv7l: 'fc71895b43658dfe8d06de20916ac60c56cc188917152d4daebea672ecf68e8a',
       i686: '54dbd0213df4e9b7cdf27a4627f84889aeb2c689c3232c0d212a44fd4f036838',
     x86_64: '88e37c6c4814da7eec1d3a3d7dd3ba48eee162df92692785687163c990819a14'
  })

  depends_on 'python3' => :logical

  no_source_build
end
