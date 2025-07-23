require 'buildsystems/pip'

class Py3_retrying < Pip
  description 'Retrying simplifies the task of adding retry behavior to just about anything.'
  homepage 'https://github.com/rholder/retrying/'
  version "1.4.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c6bddfdd8680b232ff0654eca81824451b1c0e4a61a774f03b83f185d391843f',
     armv7l: 'c6bddfdd8680b232ff0654eca81824451b1c0e4a61a774f03b83f185d391843f',
       i686: 'dabcd674a557684af09c2ca664def64f39cc58351f0851984dd8aa8ae0cf198a',
     x86_64: '960c396dfd1d5fcdb2cfed0edb4c0526a60f0288c01e5675d60713351a89ebf0'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
