require 'buildsystems/pip'

class Py3_tomli < Pip
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  version "2.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1e8c10cc8ad5f584f55de4cbac48e0bf74e655d5bd50c4dc6e1789c2fe7ce654',
     armv7l: '1e8c10cc8ad5f584f55de4cbac48e0bf74e655d5bd50c4dc6e1789c2fe7ce654',
       i686: 'e6bc6d30574430306d25723e58bfc342083d17da1027fc50792ec8238ddc7e6b',
     x86_64: 'a2b894aaa45b5d5fd55505af5214832ab28209dffbacb02d3af17ed3abb41780'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'
  depends_on 'glibc' # R

  no_source_build
end
