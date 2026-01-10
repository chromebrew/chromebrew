require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.25-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1a6c2a2f77dc067fd8e878feec4616e56593c2bc297db95d82508926ba3ba171',
     armv7l: '1a6c2a2f77dc067fd8e878feec4616e56593c2bc297db95d82508926ba3ba171',
       i686: '9e099871890e8a22dee0af18b3272e3afacb57de3506967e214b39bb643a8b0e',
     x86_64: '610ae58e9153f66375d9eb737b4379b4bef37ce51d94e8c490acff0b834b2078'
  })

  depends_on 'python3' => :build

  no_source_build
end
